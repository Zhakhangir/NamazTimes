//
//  ErrorPageInteractor.swift
//  Namaz Times
//
//  Created by &&TairoV on 22.10.2022.
//

import UIKit

enum ErrorPageType {
    case locationError, noDataErorr, unknown
    
    var title: String {
        switch self {
        case .locationError:
            return "warning".localized + "!"
        case .noDataErorr:
            return ""
        case .unknown:
            return ""
        }
    }
    
    var message: String {
        switch self {
        case .locationError:
            return "location_access".localized
        case .noDataErorr:
            return ""
        case .unknown:
            return ""
        }
    }
    
    var actionTitle: String {
        switch self {
        case .locationError:
            return "open_settings".localized
        case .noDataErorr:
            return ""
        case .unknown:
            return ""
        }
    }
}

protocol ErrorPageInteractorInput {
    func didTapButton()
    func getErrorType() -> ErrorPageType
}

class ErrorPageInteractor: ErrorPageInteractorInput {
   
    private var view: ErrorPageViewInput
    private var errorType: ErrorPageType
    
    init(view: ErrorPageViewInput, errorType: ErrorPageType) {
        self.view = view
        self.errorType = errorType
    }
    
    func didTapButton() {
        switch errorType {
        case .locationError:
            if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
                UIApplication.shared.open(url)
            }
        case .noDataErorr:
            return
        case .unknown:
            return
        }
    }
    
    func getErrorType() -> ErrorPageType {
        return errorType
    }
}


