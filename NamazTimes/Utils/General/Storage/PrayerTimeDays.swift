//
//  PrayerTimeDays.swift
//  Namaz Times
//
//  Created by &&TairoV on 16.09.2022.
//

import Foundation

enum PrayerTimeDays {
    case today, yesterdas, tomorrow
    
    var date: String {
        switch self {
        case .today:
            return Date().toString(format: "dd-MM-YYYY")
        case .yesterdas:
            return Date().dayAfter.toString(format: "dd-MM-YYYY")
        case .tomorrow:
           return  Date().dayBefore.toString(format: "dd-MM-YYYY")
        }
    }
}
