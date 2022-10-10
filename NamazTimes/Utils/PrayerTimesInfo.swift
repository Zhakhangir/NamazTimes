//
//  PrayerTimes.swift
//  Namaz Times
//
//  Created by &&TairoV on 10.09.2022.
//

import Foundation

enum PrayerTimesInfo: CaseIterable {
    
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
        case .imsak, .bamdat, .kun, .besin, .ekindi, .aqsham, .quptan:
            return true
        case .ishraq, .kerahat, .asriauual, .isfirar, .ishtibaq, .ishaisani:
            return false
        }
    }
}
