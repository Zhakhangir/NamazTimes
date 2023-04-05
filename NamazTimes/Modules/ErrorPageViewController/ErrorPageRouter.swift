//
//  ErrorPageRouter.swift
//  Namaz Times
//
//  Created by &&TairoV on 22.10.2022.
//

import UIKit

protocol ErrorPageRouterInput {
    func routeToLocationFinder()
    func openSettings()
}

class ErrorPageRouter: ErrorPageRouterInput {

    var view: ErrorPageViewInput?
    private var errorType: ErrorPageType
    
    init(errorType: ErrorPageType) {
        self.errorType = errorType
    }
    
    public func build() -> ErrorPageViewInput {
        
        let viewController = ErrorPageViewController()
        let interactor = ErrorPageInteractor(view: viewController, errorType: errorType)

        self.view = viewController
        viewController.router = self
        viewController.interactor = interactor

        return viewController
    }
    
    func routeToLocationFinder() {
        let vc = LocationFinderRouter(hideCloseButton: true).build()
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    func openSettings() {
    
    }
}
