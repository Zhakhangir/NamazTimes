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
    
    private func dailyPrayerTimesList(for day: DateHelper = .today, shortList: Bool = false) -> [DailyPrayerTime] {
        let mainData = realm.objects(CityPrayerData.self).toArray(ofType: CityPrayerData.self).first
        let times = mainData?.times.first(where: { $0.date == day.date })
        var timesList = [DailyPrayerTime]()
        let items = shortList ? PrayerTimesInfo.allCases.filter({ $0.required }) : PrayerTimesInfo.allCases
        
        for item in items {
            let prayerTime = DailyPrayerTime(code: item.code,
                                             time: (times?.value(forKey: item.code) as? String) ?? "",
                                             requiredTime: item.required,
                                             forDate: day.date)
            timesList.append(prayerTime)
        }
        
        return timesList
    }
    
    
    func getConfiguredPrayerTimes(shortList: Bool = false) -> [DailyPrayerTime] {
        var prayerTimes = dailyPrayerTimesList(shortList: shortList)
        let timeInterval = TimeInterval(TimeZone.current.secondsFromGMT())

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.Time.dateTimeDisplay.string
        dateFormatter.locale = .current
        dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.abbreviation() ?? "UTC")
        let currentTime = Date().addingTimeInterval(timeInterval)
        
        let index = prayerTimes.firstIndex(where: { item in
            guard let prayerTime = dateFormatter.date(from: item.forDate.concatenateWithSapce(item.time))?.addingTimeInterval(timeInterval) else { return false }
            print(prayerTime)
            return currentTime < prayerTime
        })
        
        if let index = index, index > 1, index < (prayerTimes.count - 1) {
            prayerTimes[index-1].selected = true
        } else {
            prayerTimes[prayerTimes.count - 1].selected = true
        }
        
        return prayerTimes
    }
}
