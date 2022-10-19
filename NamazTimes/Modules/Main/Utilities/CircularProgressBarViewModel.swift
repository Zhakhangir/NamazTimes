//
//  CircularProgressBarViewModel.swift
//  Namaz Times
//
//  Created by &&TairoV on 15.10.2022.
//

import UIKit

enum CircularProgressBarStates {
    
    case waiting, ending, normal
    
    var color: UIColor {
        switch self {
        case .waiting, .normal:
            return GeneralColor.primary
        case .ending:
            return GeneralColor.red
        }
    }
}

struct CircularProgressBarViewModel {
    
}

