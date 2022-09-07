//
//  SettingsRouter.swift
//  Namaz Times
//
//  Created by &&TairoV on 24.08.2022.
//

import Foundation

protocol SettingsRouterInput {
    func routeToLanuageSettings()
    func routeToLocationSettings()
}

class SettingsRouter: SettingsRouterInput {

    var view: SettingsViewInput?

    public func build() -> SettingsViewInput {
        let viewController = SettingsViewtroller()
        let interactor = SettingsInteractor(view: viewController)

        self.view = viewController
        viewController.router = self
        viewController.interactor = interactor

        return viewController
    }

    func routeToLanuageSettings() {
        let vc = LanguageSelectionViewController()
        view?.present(vc, animated: true, completion: nil)
    }

    func routeToLocationSettings() {
        let vc = LocationFinderRouter().build()
        vc.modalPresentationStyle = .fullScreen
        view?.present(vc, animated: true, completion: nil)
    }
}

