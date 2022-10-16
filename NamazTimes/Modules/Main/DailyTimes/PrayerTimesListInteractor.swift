//
//  DailyTimesInteractor.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation

protocol PrayerTimesListIntercatorInput {
    func getData() -> [DailyPrayerTime]
}

struct DailyPrayerTime {
    var code: String
    var startDate: String
    var startTime: String
    var nextCode: String
    var nextTime: String
    var nextDate: String
    var selected: Bool = false
    var requiredTime: Bool = false
}

class PrayerTimesListInteractor: PrayerTimesListIntercatorInput {

    var view: PrayerTimesListViewInput
    private var prayerTimes: [DailyPrayerTime] { GeneralStorageController.shared.getConfiguredPrayerTimes() }
    
    init(view: PrayerTimesListViewInput) {
        self.view = view
    }

    func getData() -> [DailyPrayerTime] {
        return prayerTimes
    }
}
