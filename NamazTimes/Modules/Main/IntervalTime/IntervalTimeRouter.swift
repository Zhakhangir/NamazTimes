//
//  HomeRouter.swift
//  NamazTimes
//
//  Created by &&TairoV on 27.05.2022.
//

import Foundation

protocol IntervalTimeRouterInput { }

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
}

