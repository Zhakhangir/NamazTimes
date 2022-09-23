//
//  BaseFont.swift
//  Namaz Times
//
//  Created by &&TairoV on 21.09.2022.
//

import UIKit.UIFont

class BaseFont: RawRepresentable, Equatable {
    
    typealias RawValue = String
    
    let rawValue: RawValue
    
    let withExtension: String
    
    required init?(rawValue: String) { fatalError("Not implemented") }

    required public init(title: String, withExtension: String) {
        self.rawValue = title
        self.withExtension = withExtension
    }
}

extension BaseFont: CommonFontProtocol {
    
    var title: String { rawValue }
    
    var bundle: Bundle { Bundle(for: BaseFont.self) }
    
    private var uiFont: UIFont? {
        if let font = UIFont(name: title, size: 16) {
            return font
        }
        
        guard let url = bundle.url(forResource: title, withExtension: withExtension),
              let cgDataProvider = CGDataProvider(url: url as CFURL),
              let cgFont = CGFont(cgDataProvider),
              CTFontManagerRegisterGraphicsFont(cgFont, nil) else {
            return nil
        }
        
        return UIFont(name: title, size: 16)
    }
    
    private static var RobotoLight: BaseFont { .init(title: "Roboto-Light", withExtension: "ttf") }
    private static var RobotoRegular: BaseFont { .init(title: "Roboto-Regular", withExtension: "ttf") }
    private static var RobotoThin: BaseFont { .init(title: "Roboto-Thin", withExtension: "ttf") }
    private static var RobotoMedium: BaseFont { .init(title: "Roboto-Medium", withExtension: "ttf") }
    private static var RobotoBold: BaseFont { .init(title: "Roboto-Bold", withExtension: "ttf") }

    static var light: UIFont { RobotoLight.uiFont ?? .systemFont(ofSize: 16, weight: .light) }
    static var regular: UIFont { RobotoRegular.uiFont ?? .systemFont(ofSize: 16, weight: .regular) }
    static var semibold: UIFont { RobotoThin.uiFont ?? .systemFont(ofSize: 16, weight: .semibold) }
    static var medium: UIFont { RobotoMedium.uiFont ?? .systemFont(ofSize: 16, weight: .medium) }
    static var bold: UIFont { RobotoBold.uiFont ?? .systemFont(ofSize: 16, weight: .bold) }
    
}

protocol CommonFontProtocol {
    
    var bundle: Bundle { get }

    var title: String { get }

    var withExtension: String { get }
}
