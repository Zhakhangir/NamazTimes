//
//  ErrorPageRouter.swift
//  Namaz Times
//
//  Created by &&TairoV on 22.10.2022.
//

import Foundation

protocol ErrorPageRouterInput {

}

class ErrorPageRouter: ErrorPageRouterInput {

    var view: ErrorPageViewInput?
    private var viewModel: ErrorPageViewModel
    
    init(view: ErrorPageViewModel) {
        self.viewModel = view
    }
    
    public func build() -> ErrorPageViewInput {
        
        let viewController = ErrorPageViewController()
        let interactor = ErrorPageInteractor(view: viewController, viewModel: viewModel)

        self.view = viewController
        viewController.router = self
        viewController.interactor = interactor

        return viewController
    }
}
