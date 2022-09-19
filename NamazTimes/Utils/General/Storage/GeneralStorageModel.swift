//
//  GeneralStorage.swift
//  NamazTimes
//
//  Created by &&TairoV on 14.07.2022.
//

import Foundation
import RealmSwift

class CityPrayerData: Object {
    @objc dynamic var cityInfo: CityInfo?
    var times = List<DailyTime>()
    
    required convenience init(data: CityData) {
        self.init()
        self.cityInfo = data.attributes
        self.times.append(objectsIn: data.days ?? [DailyTime]())
        
    }
}

class PrayerTimesVisibilitySettings: Object {
    @objc dynamic var code: String = ""
    @objc dynamic var isHidden: Bool = false

    required convenience init(code: String, isHidden: Bool) {
        self.init()
        self.code = code
        self.isHidden = isHidden
    }
}
