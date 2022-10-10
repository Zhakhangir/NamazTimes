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
    var time: String
    var selected: Bool = false
    var requiredTime: Bool = false
    var forDate: String
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
