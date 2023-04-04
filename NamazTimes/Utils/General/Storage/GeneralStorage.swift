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
    
    // MARK: Calendar view model
    mutating func getDateNameViewModel() -> DateNameViewModel {
        var viewModel = DateNameViewModel()
        let times = mainData?.times.first(where: { $0.date == DateHelper.today.date })
        
        viewModel.weekDay = Weekdays(rawValue: Calendar.current.component(.weekday, from: Date()))?.title.localized
        viewModel.gregorianCalendar = getCalendarViewModel(from: times?.date)
        viewModel.hijriCalendar = getCalendarViewModel(from: times?.islamicDate, reversed: true)
        return viewModel
    }
    
    private func getCalendarViewModel(from date: String?, reversed: Bool = false) -> CalendarViewModel? {
        var viewModel = CalendarViewModel()
        guard var dateArray = date?.components(separatedBy: "-") else {
            return nil
        }
        dateArray = reversed ? dateArray.reversed() : dateArray
        for (index, item) in dateArray.enumerated() {
            switch index {
            case 0: //day
                viewModel.day = item.first == "0" ? String(item.dropFirst()) : item
            case 1: //month
                let monthSystem = reversed ?
                HijriMonths(rawValue: Int(item) ?? 1)?.title.localized :
                GrigorianMonths(rawValue: Int(item) ?? 1)?.title.localized
                viewModel.month = monthSystem
            case 2: //year
                viewModel.year = item
            default: break;
            }
        }
        
        return viewModel
    }
    
    
    // MARK: Start function
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
            
            if (index + 1) >= items.count {
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
        let timeZone = TimeZone(identifier: TimeZone.current.abbreviation() ?? "UTC")
        var currentIndex: Int?
        
        for (index, item) in prayerTimes.enumerated() {
            let current = Date().addingTimeInterval(TimeInterval(timeZone?.secondsFromGMT() ?? 0))
            let startTime = item.startDate.concatenateWithSapce(item.startTime).toDate()
            let endTime = (item.nextDate.concatenateWithSapce(item.nextTime)).toDate()
            
            if (startTime..<endTime).contains(current) {
                currentIndex = index
                break
            }
        }
        
        return currentIndex
    }
}
