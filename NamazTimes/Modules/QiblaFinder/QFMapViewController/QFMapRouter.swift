//
//  QFMapRouter.swift
//  NamazTimes
//
//  Created by &&TairoV on 30.05.2022.
//

import Foundation

protocol QFMapRouterInput {
    func goBack()
}


class QFMapRouter: QFMapRouterInput {

    private var view: QFMapViewInput?

    func build() -> QFMapViewInput {
        let viewController = QFMapViewController()
        let interactor = QFMapInteractor(view: viewController)

        viewController.interactor = interactor
        viewController.router = self
        self.view = viewController

        return viewController
    }

    func goBack() {
        view?.dismiss(animated: true, completion: nil)
    }
}




//private func addSubviews() {
//
//}
//
//private func setupLayout() {
//    var layoutConstraints = [NSLayoutConstraint]()
//
//
//    NSLayoutConstraint.activate(layoutConstraints)
//}
//
//private func stylize() {
//
//}
//
//private func addActions() {
//
//}
//
//@objc func showMap() {
//
//}
