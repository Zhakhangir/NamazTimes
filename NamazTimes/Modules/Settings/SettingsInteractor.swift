//
//  SettingsInteractor.swift
//  Namaz Times
//
//  Created by &&TairoV on 24.08.2022.
//

import UIKit
import RealmSwift

protocol SettingsInteractorInput {
    func createElements()
    func getSectionCount() -> Int
    func getSection(at index: Int) -> SettingsTableSection
    func getNumberOfItems(in section: Int) -> Int
    func getItem(by index: IndexPath) -> SettingsItemElement
    func didSelectItem(at index: IndexPath)
}

class SettingsInteractor {

    var view: SettingsViewInput
    private let realm = try! Realm()
    private var sections = [SettingsTableSection]()
    private var cityName = GeneralStorageController.shared.getCityInfo()?.cityName

    init(view: SettingsViewInput) {
        self.view = view
    }
}

extension SettingsInteractor: SettingsInteractorInput {

    func createElements() {
        sections += [
            .init(elements: [
                .init(icon: UIImage(named: "settings_location"), title: "location".localized, description: cityName, fieldType: .location),
                .init(icon: UIImage(named: "settings_language"), title: "language".localized, description: LanguageHelper().name, fieldType: .language)
            ]),
            
            .init(elements: [
                .init(icon: UIImage(named: "settings_info"), title: "about_us".localized, description: "namaztimes.kz", fieldType: .aboutUs)
                ])
        ]

        view.reload()
    }

    func getSectionCount() -> Int {
        return sections.count
    }

    func getSection(at index: Int) -> SettingsTableSection {
        return sections[index]
    }

    func getNumberOfItems(in section: Int) -> Int {
        return sections[section].elements.count
    }

    func getItem(by index: IndexPath) -> SettingsItemElement {
        return sections[index.section].elements[index.row]
    }

    func didSelectItem(at index: IndexPath) {
        let item  = getItem(by: index)

        switch item.fieldType {
        case .location: view.routeToLocationSettings()
        case .language: view.routeToLanuageSettings(delegate: self)
        case .aboutUs:
            if let url = URL(string: "https://namaztimes.kz/information/18") {
                UIApplication.shared.open(url)
            }
        }
    }
}

extension SettingsInteractor: LanguageSelectionDelegate {
    func didSelectLanguage() {
        view.routeToParent()
    }
}

