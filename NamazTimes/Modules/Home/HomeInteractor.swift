//
//  HomeInterator.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation
import RealmSwift

protocol HomeInteractorInput {
    func getCityInfo() -> CityInfo?
    func getTimesList() -> [DailyPrayerTime]
    func getCurrentNextTime() -> (current: PrayerTimes, next: PrayerTimes)
    func getTimesListHeight() -> CGFloat
}

class HomeInteractor: HomeInteractorInput {
   
    var view: HomeViewInput
    private let realm = try! Realm()
    
    private var cityInfo = GeneralStorageController.shared.getCityInfo()
    private var dailyTime = GeneralStorageController.shared.getDailyTimes()
    private let requiredTimes = GeneralStorageController.shared.getRequiredList()
    private var timesList: [DailyPrayerTime] = []

    init(view: HomeViewInput) {
        self.view = view
        
        print(realm.configuration.fileURL, "Realm")
    }

    func getCityInfo() -> CityInfo? {
        return cityInfo
    }

    func getTimesList() -> [DailyPrayerTime] {
        return GeneralStorageController.shared.getDailyTimes()
    }

    func getTimesListHeight() -> CGFloat {
        return CGFloat(requiredTimes.count * 38)
    }
    
    func getCurrentNextTime() -> (current: PrayerTimes, next: PrayerTimes) {
        return (current: PrayerTimes.kun, next: PrayerTimes.besin)
    }
}
