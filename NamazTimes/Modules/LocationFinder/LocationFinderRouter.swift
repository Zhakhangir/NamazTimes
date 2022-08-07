//
//  LocationFinderRouter.swift
//  Namaz Times
//
//  Created by &&TairoV on 05.08.2022.
//

import Foundation
import UIKit

protocol LocationFinderRouterInput {
    func routeToHome()
}

class LocationFinderRouter: LocationFinderRouterInput {

    var view: LocationFinderViewInput?

    public func build() -> LocationFinderViewInput {
        let viewController = LocationFinderViewController()
        let interactor = LocationFinderInteractor(view: viewController)

        self.view = viewController
        viewController.router = self
        viewController.interactor = interactor

        return viewController
    }

    func routeToHome() {
        UIApplication.shared.keyWindow?.rootViewController = GeneralTabBarViewController()
    }
}
