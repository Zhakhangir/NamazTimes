//
//  HomeRouter.swift
//  NamazTimes
//
//  Created by &&TairoV on 27.05.2022.
//

import Foundation

protocol IntervalTimeRouterInput {
    func showAlert(with model: GeneralAlertModel)
}

class IntervalTimeRouter: IntervalTimeRouterInput {

    var view: IntervalTimeViewInput?

    public func build() -> IntervalTimeViewInput {
        let viewController = IntervalTimeViewController()
        let interactor = IntervalTimeIntercator(view: viewController)
    
        self.view = viewController
        viewController.router = self
        viewController.interactor = interactor

        return viewController
    }
    
    func showAlert(with model: GeneralAlertModel) {
        let alertVc = GeneralAlertPopupVc()
        let alertView = GeneralAlertPopupView()
        alertView.configure(with: model)
        alertVc.setContentView(alertView)

        view?.present(alertVc, animated: true, completion: nil)
    }
}

