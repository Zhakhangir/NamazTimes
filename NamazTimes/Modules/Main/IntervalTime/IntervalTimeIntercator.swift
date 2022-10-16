//
//  HomeInterator.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation
import RealmSwift

protocol IntervalTimeInteractorInput {
    func getCityInfo() -> CityInfo?
    func getTimesList() -> [DailyPrayerTime]
    func getCurrentTime() -> DailyPrayerTime?
    func didUpdateTimer()
    func getCurrentProgressStatus() -> (progress: Double, remining: Int)
    func getDateNames() -> (dateName: String?, islamicDateName: String?)
    func didFinishTimer()
}

class IntervalTimeIntercator: IntervalTimeInteractorInput {

    var view: IntervalTimeViewInput
    private let realm = try! Realm()
    
    private let timeZone = TimeZone(identifier: TimeZone.current.abbreviation() ?? "UTC")
    private var cityInfo = GeneralStorageController.shared.getCityInfo()
    private var prayerTimes: [DailyPrayerTime] { GeneralStorageController.shared.getConfiguredPrayerTimes(shortList: true) }
    private var totalTimeInterval = TimeInterval(0)
    private var passedTimeInterval = TimeInterval(0)
    
    init(view: IntervalTimeViewInput) {
        self.view = view
        let timeIntervals = getTotalPassedTimeInterval()
        totalTimeInterval = timeIntervals.total
        passedTimeInterval = timeIntervals.passed
    }
    
    func getCityInfo() -> CityInfo? {
        return cityInfo
    }
    
    func getTimesList() -> [DailyPrayerTime] {
        return prayerTimes
    }
    
    func getCurrentTime() -> DailyPrayerTime? {
        return prayerTimes.first(where: { $0.selected })
    }
    
    func didUpdateTimer() {
        passedTimeInterval += 1
    }
    
    func getDateNames() -> (dateName: String?, islamicDateName: String?) {
        return GeneralStorageController.shared.getDateNames()
    }
    
    func getCurrentProgressStatus() -> (progress: Double, remining: Int) {
        return (passedTimeInterval/totalTimeInterval, Int(totalTimeInterval - passedTimeInterval))
    }
    
    func didFinishTimer() {
        let timeIntervals = getTotalPassedTimeInterval()
        totalTimeInterval = timeIntervals.total
        passedTimeInterval = timeIntervals.passed
        view.reload()
    }
    
    private func getTotalPassedTimeInterval() -> (total: TimeInterval, passed: TimeInterval) {
        let currentPrayer = getTimesList().first(where: { $0.selected })
        let startTime = currentPrayer?.startDate.concatenateWithSapce(currentPrayer?.startTime).toDate() ?? Date()
        let endTime = (currentPrayer?.nextDate.concatenateWithSapce(currentPrayer?.nextTime))?.toDate() ?? Date()
        let currentTime = Date().addingTimeInterval(TimeInterval(timeZone?.secondsFromGMT() ?? 0))
    
        print(startTime, "start")
        print(endTime, "end")
        print(currentTime, "currentTime")
        return (endTime.timeIntervalSince(startTime), currentTime.timeIntervalSince(startTime))
    }
}
