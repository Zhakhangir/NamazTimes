//
//  LocationFinderInteractor.swift
//  Namaz Times
//
//  Created by &&TairoV on 05.08.2022.
//

import Foundation
import RealmSwift

protocol LocationFinderInteractorInput {
    var hideCloseButton: Bool { get }

    func getNumberOfSection() -> Int
    func getNumberOfRows(in section: Int) -> Int
    func getItem(at index: IndexPath) -> RegionCities?
    func getTitle(for section: Int) -> String?
    func searchCity(name: String?)
    func didSelectItem(at index: IndexPath)
    func checkNetworkConnection()
}

class LocationFinderInteractor {

    var view: LocationFinderViewInput
    var hideCloseButton: Bool
    private let reachability = try! Reachability()
    private var realm = try! Realm()
    private let networkManager = NetworkManager()
    private var regions = [Regions]()

    init(view: LocationFinderViewInput, hideCloseButton: Bool) {
        self.view = view
        self.hideCloseButton = hideCloseButton

        checkNetworkConnection()
    }
}

extension LocationFinderInteractor: LocationFinderInteractorInput {

    func getItem(at index: IndexPath) -> RegionCities? {
        regions[index.section].children?[index.row]
    }

    func getTitle(for section: Int) -> String? {
        regions[section].text
    }
    
    func searchCity(name: String?) {
        if (name?.count ?? 0) > 1 || (name?.count ?? 0) == 0 {
            view.spinnerState(animate: true)
            networkManager.searchCity(cityName: name ?? "") {data, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.view.showAlert(with: GeneralAlertModel(titleLabel: "error".localized, descriptionLabel: error))
                    }

                    self.view.spinnerState(animate: false)
                    self.regions = data?.results ?? [Regions]()
                    self.view.reload()
                }
            }
        }
    }

    func didSelectItem(at index: IndexPath) {
        guard let cityId = getItem(at: index)?.id else { return }
        view.cellSpinnerState(at: index, animate: true)

        networkManager.annualTimes(cityId: cityId) { data, error in
            DispatchQueue.main.async {
                self.view.cellSpinnerState(at: index, animate: false)

                if let error = error {
                    self.view.showAlert(with: GeneralAlertModel(titleLabel: "error".localized, descriptionLabel: error))
                }
                
                guard let data = data else { return }
                UserDefaults.standard.string(forKey: "cityId") == nil ?
                self.createStorage(with: data, save: cityId):
                self.updateStorage(with: data)
               
                self.view.routeToHome()
            }
        }
    }

    func getNumberOfSection() -> Int {
        regions.count
    }

    func getNumberOfRows(in section: Int) -> Int {
        regions[section].children?.count ?? 0
    }

    func checkNetworkConnection() {
        if reachability.connection == .unavailable {
            view.showAlert(with: GeneralAlertModel(titleLabel: "error".localized,descriptionLabel: "network_error".localized))
        }
    }
    
    private func createStorage(with data: CityData, save cityId: Int) {
        UserDefaults.standard.set(cityId.description, forKey:"cityId")
        UserDefaults().synchronize()
        try! self.realm.write {
            let storageData = CityPrayerData(data: data)
            self.realm.add(storageData)
        }
    }
    
    private func updateStorage(with data: CityData) {
        guard let storageData = realm.objects(CityPrayerData.self).first else { return }
        
        try! self.realm.write {
            let times = List<PreyerTimes>()
            times.append(objectsIn: data.days ?? [PreyerTimes]())
            
            storageData.times = times
            storageData.cityInfo = data.attributes
        }
    }
}
