//
//  LocationFinderInteractor.swift
//  Namaz Times
//
//  Created by &&TairoV on 05.08.2022.
//

import Foundation
import RealmSwift

protocol LocationFinderInteractorInput {
    var closeButton: Bool { get }

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
    var closeButton: Bool
    private let reachability = try! Reachability()
    private let realm = try! Realm()
    private let networkManager = NetworkManager()
    private var regions = [Regions]()

    init(view: LocationFinderViewInput, closeButton: Bool) {
        self.view = view
        self.closeButton = closeButton

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

    func didSelectItem(at index: IndexPath) {
        guard let cityId = getItem(at: index)?.id else { return }
        view.cellSpinnerState(at: index, animate: true)
        networkManager.yearTimes(cityId: cityId) { data, error in
            DispatchQueue.main.async {
                self.view.cellSpinnerState(at: index, animate: false)

                if let error = error {
                    self.view.showAlert(with: GeneralAlertModel(titleLabel: NSLocalizedString("error", comment: "error"),descriptionLabel: error , buttonTitle: "OK"))
                }

                guard let data = data else { return }
                UserDefaults.standard.set(data.cityname, forKey: "currentCity")

                let realmData = YearTimes()
                let list = List<DailyTime>()
                list.append(objectsIn: data.dailyTimes ?? [DailyTime]())
                realmData.cityName = data.cityname ?? ""
                realmData.times = list

                try! self.realm.write {
                    let allDataType = self.realm.objects(YearTimes.self)
                    self.realm.delete(allDataType)
                    self.realm.add(realmData)
                }
                self.view.routeToHome()
            }
        }
    }

    func searchCity(name: String?) {
        if (name?.count ?? 0) > 1 || (name?.count ?? 0) == 0 {
            view.spinnerState(animate: true)
            networkManager.searchCity(cityName: name ?? "") {data, error in
                DispatchQueue.main.async {
                    self.view.spinnerState(animate: false)
                    self.regions = data?.results ?? [Regions]()
                    self.view.reload()
                }
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
            view.showAlert(with: GeneralAlertModel(titleLabel: NSLocalizedString("error", comment: "error"),descriptionLabel: NSLocalizedString("network_error", comment: "error"), buttonTitle: "OK"))
        }
    }
}
