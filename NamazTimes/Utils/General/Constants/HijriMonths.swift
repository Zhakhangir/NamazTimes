//
//  HijroMonths.swift
//  NamazTimes
//
//  Created by &&TairoV on 04.04.2023.
//

import Foundation

enum HijriMonths: Int  {
    case muharram = 1, safar, rabiAlAwwal
    case rabiAlThani, jamadaAlAwwal, jamadaAlThani
    case rajab, shaban, ramadan
    case shawwal, dhulQadah, dhulHijjah
    
    var title: String {
        switch self {
        case .muharram:
            return  "muharram".localized
        case .safar:
            return  "safar".localized
        case .rabiAlAwwal:
            return  "rabiAlAwwal".localized
        case .rabiAlThani:
            return  "rabiAlThani".localized
        case .jamadaAlAwwal:
            return  "jamadaAlAwwal".localized
        case .jamadaAlThani:
            return  "jamadaAlThani".localized
        case .rajab:
            return  "rajab".localized
        case .shaban:
            return  "shaban".localized
        case .ramadan:
            return  "ramadan".localized
        case .shawwal:
            return  "shawwal".localized
        case .dhulQadah:
            return  "dhulQadah".localized
        case .dhulHijjah:
            return  "dhulHijjah".localized
        }
    }
}
