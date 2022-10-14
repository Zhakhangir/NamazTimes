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
        let tomorrowTimes = mainData?.times.first(where: { $0.date == DateHelper.tomorrow.date })
        
        var endTime = ""
        var timesList = [DailyPrayerTime]()
        let items = shortList ? PrayerTimesInfo.allCases.filter({ $0.required }) : PrayerTimesInfo.allCases
        
        for (index, item) in items.enumerated() {
            if  (index + 1) >= items.count {
                endTime = (tomorrowTimes?.value(forKey: (items[0].code)) as? String) ?? ""
            } else {
                endTime = (times?.value(forKey: (items[index+1].code)) as? String) ?? ""
            }
            let prayerTime = DailyPrayerTime(code: item.code,
                                             date: day.date,
                                             startTime: (times?.value(forKey: item.code) as? String) ?? "",
                                             endTime: endTime,
                                             nextDate: DateHelper.tomorrow.date,
                                             requiredTime: item.required)
            timesList.append(prayerTime)
        }
        
        return timesList
    }
    
    
    func getConfiguredPrayerTimes(shortList: Bool = false) -> [DailyPrayerTime] {
        
        var prayerTimes = dailyPrayerTimesList(shortList: shortList)
        var currentTimeIndex = findCurrentTimeIndex(from: prayerTimes)
            
        if currentTimeIndex == nil {
            prayerTimes = dailyPrayerTimesList(for: .yesterday, shortList: shortList)
            currentTimeIndex = findCurrentTimeIndex(from: prayerTimes)
        }
        
        currentTimeIndex != nil ? { prayerTimes[currentTimeIndex ?? 0].selected = true }() : nil
        return prayerTimes
    }
    
    private func findCurrentTimeIndex(from prayerTimes: [DailyPrayerTime]) -> Int? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.Time.dateTimeDisplay.string
        dateFormatter.locale = .current
        dateFormatter.timeZone = TimeZone(identifier:  TimeZone.current.abbreviation() ?? "UTC")
        var currentIndex: Int?
        
        for (index, item) in prayerTimes.enumerated() {
            let current = dateFormatter.string(from: Date())
            let startTime = item.date.concatenateWithSapce(item.startTime.count == 4 ? "0" + item.startTime : item.startTime)
            let endTime = index == (prayerTimes.count - 1) ?
            (item.nextDate.concatenateWithSapce(item.endTime.count == 4 ? "0" + item.endTime : item.endTime)):
            (item.date.concatenateWithSapce(item.endTime.count == 4 ? "0" + item.endTime : item.endTime))
            
            if (startTime < current) && (current < endTime) {
                currentIndex = index
                break
            }
        }
    
        
        return currentIndex
    }
}
