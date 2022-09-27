//
//  MainRouter.swift
//  Namaz Times
//
//  Created by &&TairoV on 26.09.2022.
//

import Foundation

protocol MainPageRouterInput {

}

class MainPageRouter: MainPageRouterInput {

    var view: MainPageViewInput?

    public func build() -> MainPageViewInput {
        
        let viewController = MainPageViewController()
        let interactor = MainPageInteractor(view: viewController)

        self.view = viewController
        viewController.router = self
        viewController.interactor = interactor

        return viewController
    }
}
