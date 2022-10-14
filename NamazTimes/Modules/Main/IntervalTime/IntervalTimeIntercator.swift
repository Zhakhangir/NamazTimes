//
//  HomeInterator.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation
import RealmSwift

protocol IntervalTimeInteractorInput {
    func getCityInfo() -> CityInfo?
    func getTimesList() -> [DailyPrayerTime]
    func getCurrentNextTime() -> (current: PrayerTimesInfo, next: PrayerTimesInfo)
}

class IntervalTimeIntercator: IntervalTimeInteractorInput {
   
    var view: IntervalTimeViewInput
    private let realm = try! Realm()
    
    private var cityInfo = GeneralStorageController.shared.getCityInfo()
    private var prayerTimes: [DailyPrayerTime] { GeneralStorageController.shared.getConfiguredPrayerTimes(shortList: true) }

    init(view: IntervalTimeViewInput) {
        self.view = view
    }

    func getCityInfo() -> CityInfo? {
        return cityInfo
    }

    func getTimesList() -> [DailyPrayerTime] {
        return prayerTimes
    }
    
    func getCurrentNextTime() -> (current: PrayerTimesInfo, next: PrayerTimesInfo) {
        
        return (current: PrayerTimesInfo.kun, next: PrayerTimesInfo.besin)
    }
}
