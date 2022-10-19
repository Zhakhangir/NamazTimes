//
//  DailyTimesInteractor.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import UIKit

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
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: Notification.Name(GeneralNotifications.DID_PRAYER_TIME_CHANGE.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(update),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }

    func getData() -> [DailyPrayerTime] {
        return prayerTimes
    }
    
    @objc private func update() {
        view.reload()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
