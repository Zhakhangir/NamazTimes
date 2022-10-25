//
//  ErrorPageInteractor.swift
//  Namaz Times
//
//  Created by &&TairoV on 22.10.2022.
//

import UIKit

enum ErrorPageType {
    case lcoationError, noDataErorr, unknown
}

//struct ErrorPageViewModel {
//    var title: String?
//    var message: String?
//    var buttonTitle: String?
//    var buttonAction: (()->Void)?
//}

protocol ErrorPageInteractorInput {
    func didTapButton()
}

class ErrorPageInteractor: ErrorPageInteractorInput {
   
    private var view: ErrorPageViewInput
    private var errorType: ErrorPageType
    
    init(view: ErrorPageViewInput, errorType: ErrorPageType) {
        self.view = view
        self.errorType = errorType
    }
    
    func didTapButton() {
//        viewModel.buttonAction?()
//        if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
//            UIApplication.shared.open(url)
//        }
    }
}


