//
//  UIFont+Extensions.swift
//  Namaz Times
//
//  Created by &&TairoV on 05.09.2022.
//

import UIKit

extension UIFont {

   class func getDynamicMultiplier() -> CGFloat {
        let width = UIScreen.main.bounds.width
        var multiplier: CGFloat = 1.0

        switch width {
        case 320: multiplier = 1.0
        case 375, 390: multiplier = 1.1
        case 414, 428: multiplier = 1.3
        case 476: multiplier = 1.4
        default:  multiplier = 1.0
        }

        return multiplier
    }

    class func systemFont(dynamicSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {

        return UIFont.systemFont(ofSize: getDynamicMultiplier() * dynamicSize, weight: weight)
    }

    class func monospacedDigitSystemFont(dynamicSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {

        return UIFont.monospacedDigitSystemFont(ofSize: dynamicSize * getDynamicMultiplier(), weight: weight)
    }
}
