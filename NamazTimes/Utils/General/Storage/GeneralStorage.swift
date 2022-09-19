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
    private let requiredTimes: [PrayerTimes] = [.imsak, .bamdat, .kun, .besin, .ekindi, .aqsham, .quptan]
    private let realm = try! Realm()
    
    let currentDateTime = Date().toString(format: "YYYY-MM-dd HH:mm")
    
    private let timesVisibilitySettings: [PrayerTimesVisibilitySettings] = [
        .init(code: "imsak", isHidden: false),
        .init(code: "bamdat", isHidden: false),
        .init(code: "kun", isHidden: false),
        .init(code: "ishraq", isHidden: true),
        .init(code: "kerahat", isHidden: true),
        .init(code: "besin", isHidden: false),
        .init(code: "asriauual", isHidden: true),
        .init(code: "ekindi", isHidden: false),
        .init(code: "isfirar", isHidden: true),
        .init(code: "aqsham", isHidden: false),
        .init(code: "ishtibaq", isHidden: true),
        .init(code: "quptan", isHidden: false),
        .init(code: "ishaisani", isHidden: true)
    ]
    
    func baseConfiguration() {
        if getTimesVisibilitySettings().isEmpty {
            let settings = List<PrayerTimesVisibilitySettings>()
            settings.append(objectsIn: timesVisibilitySettings)
            try! realm.write {
                self.realm.delete(realm.objects(PrayerTimesVisibilitySettings.self))
                realm.add(settings)
            }
        }
    }
    
    private func getTimesVisibilitySettings() -> [PrayerTimesVisibilitySettings] {
        return realm.objects(PrayerTimesVisibilitySettings.self).toArray(ofType: PrayerTimesVisibilitySettings.self)
    }
    
    func changeTimesVisibilitySettings(for index: Int, to value: Bool) {
        let settings = realm.objects(PrayerTimesVisibilitySettings.self)
        try! realm.write {
            settings[index].isHidden = value
        }
    }
    
    func getCityInfo() -> CityInfo? {
        return realm.objects(CityPrayerData.self).toArray(ofType: CityPrayerData.self).first?.cityInfo
    }
    
    func getDailyTimes(for day: PrayerTimeDays = .today) -> [DailyPrayerTime] {
        let mainData = realm.objects(CityPrayerData.self).toArray(ofType: CityPrayerData.self).first
        let times = mainData?.times.first(where: { $0.date == PrayerTimeDays.today.date })
        
        let dailyPrayerTimes = PrayerTimes.allCases.map { item in
            DailyPrayerTime(code: item.code,
                            time: (times?.value(forKey:  item.code) as? String),
                            isHidden: false,
                            isCurrent: false)
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
    

    func getRequiredList() -> [PrayerTimes] {
        return requiredTimes
    }
}
