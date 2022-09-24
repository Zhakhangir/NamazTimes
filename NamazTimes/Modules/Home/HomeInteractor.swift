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
    func getRowHeight() -> CGFloat
    func getTimesListHeight() -> CGFloat
}

class HomeInteractor: HomeInteractorInput {
   
    var view: HomeViewInput
    private let realm = try! Realm()
    
    private var cityInfo = GeneralStorageController.shared.getCityInfo()
    private var dailyTime = GeneralStorageController.shared.getDailyTimes()
    private var timesList: [DailyPrayerTime] = []

    init(view: HomeViewInput) {
        self.view = view
        
        print(realm.configuration.fileURL, "Realm")
    }

    func getCityInfo() -> CityInfo? {
        return cityInfo
    }

    func getTimesList() -> [DailyPrayerTime] {
        let times = GeneralStorageController.shared.getDailyTimes()
        return times.filter({$0.required})
    }

    func getTimesListHeight() -> CGFloat {
        return CGFloat(PrayerTimes.allCases.filter({$0.required}).count) * getRowHeight()
    }
    
    func getRowHeight() -> CGFloat {
        return (view.contentView.frame.height / 7)
    }
    
    func getCurrentNextTime() -> (current: PrayerTimes, next: PrayerTimes) {
        return (current: PrayerTimes.kun, next: PrayerTimes.besin)
    }
}
