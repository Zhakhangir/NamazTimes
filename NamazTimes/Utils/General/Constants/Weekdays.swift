//
//  Weekdays.swift
//  NamazTimes
//
//  Created by &&TairoV on 04.04.2023.
//

import Foundation

enum Weekdays: Int {
    case sunday = 1, monday, tuesday, wednesday
    case thursday, friday, saturday
    
    var title: String {
        switch self {
        case .monday:
           return "monday".localized
        case .tuesday:
            return "tuesday".localized
        case .wednesday:
            return "wednesday".localized
        case .thursday:
            return "thursday".localized
        case .friday:
            return "friday".localized
        case .saturday:
            return "saturday".localized
        case .sunday:
            return "sunday".localized
        }
    }
}
