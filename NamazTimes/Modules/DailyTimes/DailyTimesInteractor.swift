//
//  DailyTimesInteractor.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation

protocol DailyTimesInteractorInput {
    func getData() -> [DailyPrayerTime]
    func didChageSwitch(for code: String, to value: Bool)
}

struct DailyPrayerTime {
    var code: String?
    var time: String?
    var isHidden: Bool = false
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

    func didChageSwitch(for code: String, to value: Bool) {
        GeneralStorageController.shared.changeTimesVisibilitySettings(for: code, to: value)
    }
}
