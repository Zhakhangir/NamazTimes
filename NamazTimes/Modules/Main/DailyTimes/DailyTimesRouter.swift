//
//  DailyTimesRouter.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation

protocol DailyTimesRouterInput {

}

class DailyTimesRouter: DailyTimesRouterInput {

    var view: DailyTimesViewInput?

    public func build() -> DailyTimesViewInput {
        let viewController = DailyTimesViewController()
        let interactor = DailyTimesInteractor(view: viewController)

        self.view = viewController
        viewController.router = self
        viewController.interactor = interactor

        return viewController
    }
}
