//
//  LocationFinderInteractor.swift
//  Namaz Times
//
//  Created by &&TairoV on 05.08.2022.
//

import Foundation

protocol LocationFinderInteractorInput {
    func getNumberOfSection() -> Int
    func getNumberOfRows(in section: Int) -> Int
    func getItem(at index: IndexPath) -> RegionCities?
    func getTitle(for section: Int) -> String?
    func searchCity(name: String?)
    func didSelectItem(at index: IndexPath)
}

class LocationFinderInteractor {

    var view: LocationFinderViewInput
    private let networkManager = NetworkManager()
    private var regions = [Regions]()

    init(view: LocationFinderViewInput) {
        self.view = view
    }

    private func showAlert(with model: GeneralAlertModel) {
        let alertVc = GeneralAlertPopupVc()
        let alertView = GeneralAlertPopupView()
        alertView.configure(with: model)
        alertVc.setContentView(alertView)

        view.present(alertVc, animated: true, completion: nil)
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
        
        LoadingLayer.shared.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.view.routeToHome()
            LoadingLayer.shared.hide()

        }
//        view.fieldSpinner(animate: true)
//        networkManager.yearTimes(cityId: cityId) { data, error in
//            DispatchQueue.main.async {
//                self.view.fieldSpinner(animate: false)
//
//                if let _ = data {
//                    self.showAlert(with: GeneralAlertModel.init(titleLabel: "Succes", buttonTitle: "Ok"))
//                }
//
//                if let error = error {
//                    self.showAlert(with: GeneralAlertModel(titleLabel: error, buttonTitle: "OK"))
//                }
//            }
//        }
    }

    func searchCity(name: String?) {
        if (name?.count ?? 0) > 1 {
            view.fieldSpinner(animate: true)
            networkManager.searchCity(cityName: name ?? "") {data, error in
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    self.regions = data.results ?? [Regions]()
                    self.view.fieldSpinner(animate: false)
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
}
