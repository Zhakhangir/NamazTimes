//
//  HomeInterator.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation
import RealmSwift

protocol HomeInteractorInput {
    func getAnnualTimes() -> YearTimes?
    func getTimesList() -> [PrayerTimesList]
    func getCurrentNextTime() -> (current: PrayerTimes, next: PrayerTimes)
    func getTimesListHeight() -> CGFloat
}

class HomeInteractor: HomeInteractorInput {

    var view: HomeViewInput
    private let realm = try! Realm()
    
    private var annualTimes = GeneralStorageController.shared.getAnnualTime()
    private var dailyTime = GeneralStorageController.shared.getDailyTimes()
    private let requiredTimes = GeneralStorageController.shared.getRequiredList()
    private var timesList: [PrayerTimesList] = []

    init(view: HomeViewInput) {
        self.view = view
        
    }

    func getAnnualTimes() -> YearTimes? {
        return annualTimes
    }

    func getTimesList() -> [PrayerTimesList] {
        timesList.removeAll()
        
        for item in requiredTimes {
            var listItem = PrayerTimesList()
            listItem.name = item.code.localized
            listItem.time = dailyTime.value(forKey: item.code) as? String
            timesList.append(listItem)
        }
        return timesList
    }

    func getTimesListHeight() -> CGFloat {
        return CGFloat(requiredTimes.count * 38)
    }
    
    func getCurrentNextTime() -> (current: PrayerTimes, next: PrayerTimes) {
        let current = GeneralStorageController.shared.currentPrayerTime()
        return (current: current.current, next: current.next)
    }
}
