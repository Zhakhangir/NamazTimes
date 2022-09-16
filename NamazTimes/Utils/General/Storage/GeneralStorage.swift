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
    
    private let timesSettings: [PrayerTime] = [
        .init(name: "imsak", isHidden: false),
        .init(name: "bamdat", isHidden: false),
        .init(name: "kun", isHidden: false),
        .init(name: "ishraq", isHidden: false),
        .init(name: "kerahat", isHidden: false),
        .init(name: "besin", isHidden: false),
        .init(name: "asriauual", isHidden: false),
        .init(name: "ekindi", isHidden: false),
        .init(name: "isfirar", isHidden: false),
        .init(name: "aqsham", isHidden: false),
        .init(name: "ishtibaq", isHidden: false),
        .init(name: "quptan", isHidden: false),
        .init(name: "ishaisani", isHidden: false)
    ]
    
    func baseConfiguration() {
        if UserDefaults.standard.string(forKey: "baseConfig") == nil {
            let settings = PrayerTimesListSettings()
            settings.prayerTimes.append(objectsIn: timesSettings)
            UserDefaults.standard.set(true, forKey: "baseConfig")
            try! realm.write {
                self.realm.delete(realm.objects(PrayerTimesListSettings.self))
                realm.add(settings)
            }
        }
    }
    
    func getAnnualTime() -> YearTimes? {
        return realm.objects(YearTimes.self).toArray(ofType: YearTimes.self).first
    }
    
    func getPrayerTimesListSettings() -> PrayerTimesListSettings {
        return realm.objects(PrayerTimesListSettings.self).toArray(ofType: PrayerTimesListSettings.self).first ?? PrayerTimesListSettings()
    }
    
    func getDailyTimes(for day: PrayerTimeDays = .today) -> DailyTime {
        let annualTimes = realm.objects(YearTimes.self).toArray(ofType: YearTimes.self).first
        return annualTimes?.times.first(where: { ($0.value(forKey: "date") as? String) == day.date }) ?? DailyTime()
    }
    
    func currentPrayerTime(for day: PrayerTimeDays = .today) -> (current: PrayerTimes, next: PrayerTimes) {
        let dailyTimes = getDailyTimes()
        
        let currentIndex = requiredTimes.firstIndex(where: { item in
            let dateTime = day.date.concatenateWithSapce(dailyTimes.value(forKey: item.code))
            return currentDateTime.toTimeInterval(format: .dateTimeDisplay)  < dateTime.toTimeInterval(format: .dateTimeDisplay)
        })
        
        var current = PrayerTimes.imsak
        var next = PrayerTimes.kun
        
        if currentIndex == 0 {
            //before day imsak
        } else if currentIndex == nil {
            //after day imsak
        } else if (currentIndex ?? 0) > 0 {
            current = requiredTimes[((currentIndex ?? 1) - 1)]
            next = requiredTimes[(currentIndex ?? 1)]
        }
        
        return (current: current, next: next)
    }
    
    
    
    func getRequiredList() -> [PrayerTimes] {
        return requiredTimes
    }
}
