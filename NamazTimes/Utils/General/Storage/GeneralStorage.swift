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
    private lazy var mainData = realm.objects(CityPrayerData.self).toArray(ofType: CityPrayerData.self).first
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.Time.dateTimeDisplay.string
        dateFormatter.locale = .current
        dateFormatter.timeZone = TimeZone(identifier:  TimeZone.current.abbreviation() ?? "UTC")
        return dateFormatter
    }()
    
    func getCityInfo() -> CityInfo? {
        return realm.objects(CityPrayerData.self).toArray(ofType: CityPrayerData.self).first?.cityInfo
    }
    
    
    mutating func getConfiguredPrayerTimes(shortList: Bool = false) -> [DailyPrayerTime] {
        
        var prayerTimes = dailyPrayerTimesList(shortList: shortList)
        var currentTimeIndex = findCurrentTimeIndex(from: prayerTimes)
            
        if currentTimeIndex == nil {
            prayerTimes = dailyPrayerTimesList(for: .yesterday, shortList: shortList)
            currentTimeIndex = findCurrentTimeIndex(from: prayerTimes)
        }
        
        currentTimeIndex != nil ? { prayerTimes[currentTimeIndex ?? 0].selected = true }() : nil
        return prayerTimes
    }
    
    mutating func getDateNameViewModel() -> DateNameViewModel {
        var viewModel = DateNameViewModel()
        let times = mainData?.times.first(where: { $0.date == DateHelper.today.date })
                
        viewModel.weekDay = times?.dayName
        // 1 Nюнь 2022
        viewModel.dateName = times?.day?.replacingOccurrences(of: " -", with: "").concatenateWithSapce(Date().toString(format: "yyyy"))
        viewModel.islamicName = times?.islamicDateInWords
        viewModel.date = times?.date
        viewModel.islamicDate = times?.islamicDate
        return viewModel
    }
    
    private mutating func dailyPrayerTimesList(for day: DateHelper = .today, shortList: Bool = false) -> [DailyPrayerTime] {
        let tommorrow: DateHelper = day == .yesterday ? .today : .tomorrow
        let times = mainData?.times.first(where: { $0.date == day.date })
        let tomorrowTimes = mainData?.times.first(where: { $0.date == tommorrow.date })
        let items = shortList ? PrayerTimesInfo.allCases.filter({ $0.required }) : PrayerTimesInfo.allCases
       
        var timesList = [DailyPrayerTime]()
        var startTime = ""
        var nextDate = ""
        var nextTime = ""
        var nextCode = ""
        
        for (index, item) in items.enumerated() {
            startTime = (times?.value(forKey: item.code) as? String) ?? ""
            
            if  (index + 1) >= items.count {
                nextCode = items[0].code
                nextTime = (tomorrowTimes?.value(forKey: nextCode) as? String) ?? ""
                nextDate = tommorrow.date
            } else {
                nextDate = day.date
                nextCode = (items[index+1].code)
                nextTime = (times?.value(forKey: nextCode) as? String) ?? ""
            }
            
            let prayerTime = DailyPrayerTime(code: item.code,
                                             startDate: day.date,
                                             startTime: startTime.count == 4 ? "0" + startTime : startTime,
                                             nextCode: nextCode,
                                             nextTime: nextTime.count == 4 ? "0" + nextTime : nextTime,
                                             nextDate: nextDate,
                                             requiredTime: item.required)
            timesList.append(prayerTime)
        }
        
        return timesList
    }
    
    private func findCurrentTimeIndex(from prayerTimes: [DailyPrayerTime]) -> Int? {
    
        var currentIndex: Int?
        
        for (index, item) in prayerTimes.enumerated() {
            let current = dateFormatter.string(from: Date())
            let startTime = item.startDate.concatenateWithSapce(item.startTime)
            let endTime = (item.nextDate.concatenateWithSapce(item.nextTime))
            
            if (startTime <= current) && (current < endTime) {
                currentIndex = index
                break
            }
        }
        
        return currentIndex
    }
}
