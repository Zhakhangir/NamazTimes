//
//  GrigorianMonths.swift
//  NamazTimes
//
//  Created by &&TairoV on 04.04.2023.
//
 
enum GrigorianMonths: Int {
    case january = 1,february, marhc
    case april, may, june
    case july, august, september
    case  october, november, december
    
    var title: String {
        switch self {
        case .january:
            return "january".localized
        case .february:
            return "february".localized
        case .marhc:
            return "marhc".localized
        case .april:
            return "april".localized
        case .may:
            return "may".localized
        case .june:
            return "june".localized
        case .july:
            return "july".localized
        case .august:
            return "august".localized
        case .september:
            return "september".localized
        case .october:
            return "october".localized
        case .november:
            return "november".localized
        case .december:
            return "december".localized
        }
    }
}
