//
//  GeneralColor.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit.UIColor

enum GeneralColor: String, CaseIterable {

    case _3E6D7C                                                // Primary
    case _C5C7C6                                                // Secondary
    case _F4C751
    case _D6D6D6                                                // Blur background
    case _000000, _242424, _454545, _848484, _C5C5C5, _EEEEEE   // Grayscale
    case _54426B, _ED6A5A, _DC602E, _92D5E6, _33658A, _E0AFA0,  // Additional colors
         _623CEA, _987284, _9792E3, _5C6784, _7698B3, _FF8427
    case _4EBC73, _0F0F0F, _3B4045, _82878D, _A8ACB1, _D0D3D6,  // Inspector colors
         _EAECED, _EFF0F3, _FFFFFF, _F7F7F7, _BD364F, _40B160,
         _757575, _8E8E93, _202020, _636366, _F2F2F7, _3A3A3C,
         _DB2547

    public var uiColor: UIColor { UIColor(hex: hex) ?? .black }
    public var cgColor: CGColor { uiColor.cgColor }
    public var hex: String { rawValue.replacingOccurrences(of: "_", with: "#") }
}

extension GeneralColor {

    // Primary
    static var primary: UIColor { _3E6D7C.uiColor }

    // Secondary
    static var secondary: UIColor { _C5C7C6.uiColor }

    //Blur background
    static var blur: UIColor { _D6D6D6.uiColor }

    // Grayscale
    static var grayscaleBlack: UIColor { _000000.uiColor }
    static var grayscaleLightBlack: UIColor { _242424.uiColor }
    static var grayscaleDarkGray: UIColor { _454545.uiColor }
    static var grayscaleGray: UIColor { _848484.uiColor }
    static var grayscaleLightGray: UIColor { _C5C5C5.uiColor }
    static var grayscaleTooLightGray: UIColor { _EEEEEE.uiColor }

    // Inspector colors
    static var green: UIColor { _4EBC73.uiColor }
    static var green_smooth: UIColor { _40B160.uiColor }
    static var black: UIColor { _0F0F0F.uiColor }
    static var black2: UIColor { _3B4045.uiColor }
    static var black3: UIColor { _8E8E93.uiColor }
    static var darkGray: UIColor { _82878D.uiColor }
    static var gray: UIColor { _A8ACB1.uiColor }
    static var lightGray: UIColor { _D0D3D6.uiColor }
    static var tooLightGray: UIColor { _EAECED.uiColor }
    static var blueGray: UIColor { _EFF0F3.uiColor }
    static var white: UIColor { _FFFFFF.uiColor }
    static var backgroundGray: UIColor { _F7F7F7.uiColor }
    static var red: UIColor { _BD364F.uiColor }
    static var shadowColor: UIColor { _202020.uiColor }

    //Title colors
    static var el_subtitle: UIColor { _636366.uiColor }
}
