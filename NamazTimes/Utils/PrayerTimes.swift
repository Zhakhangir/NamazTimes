//
//  PrayerTimes.swift
//  Namaz Times
//
//  Created by &&TairoV on 10.09.2022.
//

import Foundation

enum PrayerTimes: CaseIterable {
    
    case imsak, bamdat, kun, ishraq, kerahat
    case besin, asriauual, ekindi, isfirar, aqsham
    case ishtibaq, quptan, ishaisani
    
    var code: String {
        switch self {
        case .imsak:
            return "imsak"
        case .bamdat:
            return "bamdat"
        case .kun:
            return "kun"
        case .ishraq:
            return "ishraq"
        case .kerahat:
            return "kerahat"
        case .besin:
            return "besin"
        case .asriauual:
            return "asriauual"
        case .ekindi:
            return "ekindi"
        case .isfirar:
            return "isfirar"
        case .aqsham:
            return "aqsham"
        case .ishtibaq:
            return "ishtibaq"
        case .quptan:
            return "quptan"
        case .ishaisani:
            return "ishaisani"
        }
    }
    
    var required: Bool {
        switch self {
        case .imsak:
            return true
        case .bamdat:
            return true
        case .kun:
            return true
        case .ishraq:
            return false
        case .kerahat:
            return false
        case .besin:
            return true
        case .asriauual:
            return false
        case .ekindi:
            return true
        case .isfirar:
            return false
        case .aqsham:
            return true
        case .ishtibaq:
            return false
        case .quptan:
            return true
        case .ishaisani:
            return false
        }
    }
}
