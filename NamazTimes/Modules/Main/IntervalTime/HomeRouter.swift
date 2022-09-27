//
//  HomeRouter.swift
//  NamazTimes
//
//  Created by &&TairoV on 27.05.2022.
//

import Foundation

protocol HomeRouterInput { }

class HomeRouter: HomeRouterInput {

    var view: HomeViewInput?

    public func build() -> HomeViewInput {
        let viewController = HomeViewController()
        let interactor = HomeInteractor(view: viewController)

        self.view = viewController
        viewController.router = self
        viewController.interactor = interactor

        return viewController
    }
}

