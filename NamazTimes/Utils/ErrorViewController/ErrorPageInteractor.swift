//
//  ErrorPageInteractor.swift
//  Namaz Times
//
//  Created by &&TairoV on 22.10.2022.
//

import UIKit

struct ErrorPageViewModel {
    var title: String?
    var message: String?
    var buttonTitle: String?
    var buttonAction: (()->Void)?
}

protocol ErrorPageInteractorInput {
    func didTapButton()
}

class ErrorPageInteractor: ErrorPageInteractorInput {
   
    private var view: ErrorPageViewInput
    private var viewModel: ErrorPageViewModel
    
    init(view: ErrorPageViewInput, viewModel: ErrorPageViewModel) {
        self.view = view
        self.viewModel = viewModel
    }
    
    func didTapButton() {
        viewModel.buttonAction?()
//        if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
//            UIApplication.shared.open(url)
//        }
    }
}


