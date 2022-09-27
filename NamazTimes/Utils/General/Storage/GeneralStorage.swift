//
//  GeneralStorageInteractor.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.07.2022.
//

import Foundation
import RealmSwift

struct GeneralStorageController {
    
    static var shared = GeneralStorageController()
    private let realm = try! Realm()
    
    func getCityInfo() -> CityInfo? {
        return realm.objects(CityPrayerData.self).toArray(ofType: CityPrayerData.self).first?.cityInfo
    }
    
    func getDailyTimes(for day: PrayerTimeDays = .today) -> [DailyPrayerTime] {
        let mainData = realm.objects(CityPrayerData.self).toArray(ofType: CityPrayerData.self).first
        let times = mainData?.times.first(where: { $0.date == PrayerTimeDays.today.date })
        
        var dailyPrayerTimes = [DailyPrayerTime]()
        
        for (_, item) in PrayerTimes.allCases.enumerated() {
            let prayerTime = DailyPrayerTime(code: item.code,
                                             time: times?.value(forKey: item.code) as? String,
                                             selected: false ,
                                             required: item.required)
            dailyPrayerTimes.append(prayerTime)
        }
        
        return dailyPrayerTimes
    }
    
//
//    func currentPrayerTime(for day: PrayerTimeDays = .today) -> (current: PrayerTimes, next: PrayerTimes) {
//        let dailyTimes = getDailyTimes()
//
//        let currentIndex = requiredTimes.firstIndex(where: { item in
//            let dateTime = day.date.concatenateWithSapce(dailyTimes.value(forKey: item.code))
//            return currentDateTime.toTimeInterval(format: .dateTimeDisplay)  < dateTime.toTimeInterval(format: .dateTimeDisplay)
//        })
//
//        var current = PrayerTimes.imsak
//        var next = PrayerTimes.kun
//
//        if currentIndex == 0 {
//            //before day imsak
//        } else if currentIndex == nil {
//            //after day imsak
//        } else if (currentIndex ?? 0) > 0 {
//            current = requiredTimes[((currentIndex ?? 1) - 1)]
//            next = requiredTimes[(currentIndex ?? 1)]
//        }
//
//        return (current: current, next: next)
//    }

}
