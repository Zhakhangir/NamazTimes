//
//  CompassRouter.swift
//  NamazTimes
//
//  Created by &&TairoV on 27.05.2022.
//

import Foundation

protocol QFCompassRouterInput {
    func showQFMap()
}

class QFCompassRouter: QFCompassRouterInput {

    var view: QFCompassViewInput?

    func build() -> QFCompassViewInput {
        let viewController = QFCompassViewController()
        let interactor = QFCompassInteractor(view: viewController)

        viewController.interactor = interactor
        viewController.router = self
        self.view = viewController

        return viewController
    }

    func showQFMap() {
        let vc = QFMapRouter().build()
        vc.modalPresentationStyle = .fullScreen
        view?.present(vc, animated: true, completion: nil)
    }
}

