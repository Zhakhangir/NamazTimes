//
//  LanguageHelper.swift
//  Namaz Times
//
//  Created by &&TairoV on 09.09.2022.
//

import Foundation

enum LanguageHelper {
    case en, kk, ru

    init() {
        let code = UserDefaults.standard.string(forKey: "language")
        switch code {
        case "en": self = .en
        case "kk": self = .kk
        case "ru": self = .ru
        default : self = .kk
        }
    }

    var name: String {
        switch self {
        case .en:
            return "English"
        case .kk:
            return "Қазақ"
        case .ru:
            return "Русский"
        }
    }

    var code: String {
        switch self {
        case .en:
            return "en"
        case .kk:
            return "kk"
        case .ru:
            return "ru"
        }
    }
}
