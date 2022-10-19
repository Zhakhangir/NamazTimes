//
//  HomeInterator.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import UIKit

protocol IntervalTimeInteractorInput {
    func getCityInfo() -> CityInfo?
    func getTimesList() -> [DailyPrayerTime]
    func getCurrentTime() -> DailyPrayerTime?
    func didUpdateTimer()
    func getCurrentProgressStatus() -> (progress: Double, remining: Int)
    func getDateNames() -> (dateName: NSAttributedString, islamicDateName: NSAttributedString)
    func reloadTimes()
}

struct DateNameViewModel {
    var dateName: String?
    var islamicName: String?
    var date: String?
    var islamicDate: String?
    var weekDay: String?
}

class IntervalTimeIntercator: IntervalTimeInteractorInput {

    var view: IntervalTimeViewInput
    
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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
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
    
    func getDateNames() -> (dateName: NSAttributedString, islamicDateName: NSAttributedString) {
        let dates = GeneralStorageController.shared.getDateNameViewModel()
        
        // 12 Iyun 2022
        let dateName = dates.dateName?.components(separatedBy: " ") ?? [""]
        let islamicDateName = dates.islamicName?.components(separatedBy: " ") ?? [""]
        
        return (getAttributedDateName(date: dateName), getAttributedDateName(date: islamicDateName))
    }
    
    func getCurrentProgressStatus() -> (progress: Double, remining: Int) {
        return (passedTimeInterval/totalTimeInterval, Int(totalTimeInterval - passedTimeInterval))
    }
    
    func reloadTimes() {
        let timeIntervals = getTotalPassedTimeInterval()
        totalTimeInterval = timeIntervals.total
        passedTimeInterval = timeIntervals.passed
        view.reload()
    }
    
    @objc  private func didBecomeActive() {
        view.reload()
        view.reloadDate()
    }
    
    private func getTotalPassedTimeInterval() -> (total: TimeInterval, passed: TimeInterval) {
        let currentPrayer = getTimesList().first(where: { $0.selected })
        let startTime = currentPrayer?.startDate.concatenateWithSapce(currentPrayer?.startTime).toDate() ?? Date()
        let endTime = (currentPrayer?.nextDate.concatenateWithSapce(currentPrayer?.nextTime))?.toDate() ?? Date()
        let currentTime = Date().addingTimeInterval(TimeInterval(timeZone?.secondsFromGMT() ?? 0))

        return (endTime.timeIntervalSince(startTime), currentTime.timeIntervalSince(startTime))
    }
    
    private func getAttributedDateName(date: [String]) -> NSAttributedString {
        let attrString = NSMutableAttributedString()
        
        for (index, item) in date.enumerated() {
            switch index {
            case 0:
                attrString.append(NSAttributedString(string: item + "\n", attributes: [
                    .font: UIFont.systemFont(ofSize: 32, weight: .bold)
                ]))
            case 1,2:
                attrString.append(NSAttributedString(string: item + "\n", attributes: [
                    .font: UIFont.systemFont(ofSize: 24, weight: .regular)
                ]))
            default: break;
            }
        }
        
        return attrString
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
