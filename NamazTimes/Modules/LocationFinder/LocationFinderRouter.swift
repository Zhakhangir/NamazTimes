//
//  LocationFinderRouter.swift
//  Namaz Times
//
//  Created by &&TairoV on 05.08.2022.
//

import Foundation
import UIKit

protocol LocationFinderRouterInput {
    func showAlert(with model: GeneralAlertModel)
    func routeToHome()
    func close()
}

class LocationFinderRouter: LocationFinderRouterInput {

    private var view: LocationFinderViewInput?
    private var hideCloseButton: Bool

    init(hideCloseButton: Bool = true) {
        self.hideCloseButton = hideCloseButton
    }

    public func build() -> LocationFinderViewInput {
        let viewController = LocationFinderViewController()
        let interactor = LocationFinderInteractor(view: viewController, hideCloseButton: hideCloseButton)

        self.view = viewController
        viewController.router = self
        viewController.interactor = interactor

        return viewController
    }

    func routeToHome() {
        guard let window = UIApplication.shared.keyWindow else { return }
        let vc = GeneralTabBarViewController()
        
        window.rootViewController = vc
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }

    func close() {
        view?.dismiss(animated: true, completion: nil)
    }

    func showAlert(with model: GeneralAlertModel) {
        let alertVc = GeneralAlertPopupVc()
        let alertView = GeneralAlertPopupView()
        alertView.configure(with: model)
        alertVc.setContentView(alertView)

        view?.present(alertVc, animated: true, completion: nil)
    }
}
