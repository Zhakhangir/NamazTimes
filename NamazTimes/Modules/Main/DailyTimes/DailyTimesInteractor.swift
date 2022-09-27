//
//  DailyTimesInteractor.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation

protocol DailyTimesInteractorInput {
    func getData() -> [DailyPrayerTime]
}

struct DailyPrayerTime {
    var code: String?
    var time: String?
    var selected: Bool = false
    var required: Bool = false
}

class DailyTimesInteractor: DailyTimesInteractorInput {

    var view: DailyTimesViewInput
    private var prayerTimesVisibilitySettings = [PrayerTimesVisibilitySettings]()
    
    init(view: DailyTimesViewInput) {
        self.view = view
    }

    func getData() -> [DailyPrayerTime] {
        return GeneralStorageController.shared.getDailyTimes()
    }
}
