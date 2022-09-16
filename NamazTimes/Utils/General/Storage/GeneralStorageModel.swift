//
//  GeneralStorage.swift
//  NamazTimes
//
//  Created by &&TairoV on 14.07.2022.
//

import Foundation
import RealmSwift

class YearTimes: Object {
    @Persisted var cityName: String = ""
    @Persisted var times = List<DailyTime>()
}

class PrayerTimesListSettings: Object {
    @Persisted var prayerTimes: List<PrayerTime>
}

class PrayerTime: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var isHidden: Bool = false

    required convenience init(name: String, isHidden: Bool) {
        self.init()
        self.name = name
        self.isHidden = isHidden
    }
}
