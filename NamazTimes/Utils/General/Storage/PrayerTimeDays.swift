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
            return Date().toString(format: "YYYY-MM-dd")
        case .yesterdas:
            return Date().dayAfter.toString(format: "YYYY-MM-dd")
        case .tomorrow:
           return  Date().dayBefore.toString(format: "YYYY-MM-dd")
        }
    }
}
