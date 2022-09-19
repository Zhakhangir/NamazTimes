//
//  DailyTimesInteractor.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation

protocol DailyTimesInteractorInput {
    func getData() -> [DailyPrayerTime]
    func didChageSwitch(for index: IndexPath, to value: Bool)
}

struct DailyPrayerTime {
    var code: String?
    var time: String?
    var isHidden: Bool = false
    var isCurrent: Bool = false
}

class DailyTimesInteractor: DailyTimesInteractorInput {

    var view: DailyTimesViewInput
    private var prayerTimesVisibilitySettings = [PrayerTimesVisibilitySettings]()
    private var dailyTimes = [DailyPrayerTime]()
    
    init(view: DailyTimesViewInput) {
        self.view = view
        
        dailyTimes = GeneralStorageController.shared.getDailyTimes()
    }

    func getData() -> [DailyPrayerTime] {
        return dailyTimes
    }

    func didChageSwitch(for index: IndexPath, to value: Bool) {
        GeneralStorageController.shared.changeTimesVisibilitySettings(for: index.row, to: value)
    }
}
