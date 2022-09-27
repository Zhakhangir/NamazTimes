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
    private let realm = try! Realm()
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
                let storageData = CityPrayerData(data: data)
                
                try! self.realm.write {
                    self.realm.delete(self.realm.objects(CityPrayerData.self))
                    self.realm.delete(self.realm.objects(CityInfo.self))
                    self.realm.delete(self.realm.objects(DailyTime.self))
                    self.realm.add(storageData)
                }
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
}
