//
//  PrayerTimeDays.swift
//  Namaz Times
//
//  Created by &&TairoV on 16.09.2022.
//

import Foundation

enum DateHelper {
    case currentTime, today, todayDT, yesterday, yesterdayDT, tomorrow, tomorrowDT
    
    var date: String {
        switch self {
        case .today:
            return Date().toString(format: "dd-MM-yyyy")
        case .todayDT:
            return Date().toString(format: "dd-MM-yyyy HH:mm")
        case .yesterday:
            return Date().dayAfter.toString(format: "dd-MM-yyyy")
        case .yesterdayDT:
            return Date().dayAfter.toString(format: "dd-MM-yyyy HH:mm")
        case .tomorrow:
           return  Date().dayBefore.toString(format: "dd-MM-yyyy")
        case .tomorrowDT:
           return  Date().dayBefore.toString(format: "dd-MM-yyyy HH:mm")
        case .currentTime:
            return Date().toString(format: "HH:mm")
        }
    }
}
