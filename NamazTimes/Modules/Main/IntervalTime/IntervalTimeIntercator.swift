//
//  HomeInterator.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import UIKit

enum VersionError: Error {
    case invalidBundleInfo, invalidResponse
}

protocol IntervalTimeInteractorInput {
    func getCityInfo() -> CityInfo?
    func getTimesList() -> [DailyPrayerTime]
    func getCurrentTime() -> DailyPrayerTime?
    func didUpdateTimer()
    func getCurrentProgressStatus() -> (progress: Double, remining: Int)
    func getCalendarViewModels() -> DateNameViewModel
    func reloadTimer()
    func viewDidload()
}

struct DateNameViewModel {
    var hijriCalendar: CalendarViewModel?
    var gregorianCalendar: CalendarViewModel?
    var hijriDate: String?
    var gregorianDate: String?
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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
    }
    
    func viewDidload() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            do {
                let update = try self?.isUpdateAvailable()
                if update ?? false {
                    DispatchQueue.main.async {
                        self?.view.showAlert(with: .init(
                            titleLabel: "",
                            descriptionLabel: "newVersion".localized,
                            buttonTitle: "update".localized,
                            actionButtonTapped: {
                            if let url = URL(string: "itms-apps://itunes.apple.com/us/app/prayertimes/id6444033060"),
                               UIApplication.shared.canOpenURL(url){
                                    if #available(iOS 10.0, *) {
                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                    } else {
                                        UIApplication.shared.openURL(url)
                                    }
                                }
                            },
                            withCancel: true)
                        )
                    }
                }
            } catch {
                print(error)
            }
        }
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
    
    func getCalendarViewModels() -> DateNameViewModel {
        return GeneralStorageController.shared.getDateNameViewModel()
    }
    
    func getCurrentProgressStatus() -> (progress: Double, remining: Int) {
        return (passedTimeInterval/totalTimeInterval, Int(totalTimeInterval - passedTimeInterval))
    }
    
    func reloadTimer() {
        let timeIntervals = getTotalPassedTimeInterval()
        totalTimeInterval = timeIntervals.total
        passedTimeInterval = timeIntervals.passed
        view.reload()
    }
    
    @objc  private func didBecomeActive() {
        reloadTimer()
        view.reload()
        view.reloadCalendar()
    }
    
    private func getTotalPassedTimeInterval() -> (total: TimeInterval, passed: TimeInterval) {
        let currentPrayer = getTimesList().first(where: { $0.selected })
        let startTime = currentPrayer?.startDate.concatenateWithSapce(currentPrayer?.startTime).toDate() ?? Date()
        let endTime = (currentPrayer?.nextDate.concatenateWithSapce(currentPrayer?.nextTime))?.toDate() ?? Date()
        let currentTime = Date().addingTimeInterval(TimeInterval(timeZone?.secondsFromGMT() ?? 0))

        return (endTime.timeIntervalSince(startTime), currentTime.timeIntervalSince(startTime))
    }
    
    private func isUpdateAvailable() throws -> Bool {
         guard let info = Bundle.main.infoDictionary,
             let currentVersion = info["CFBundleShortVersionString"] as? String,
             let identifier = info["CFBundleIdentifier"] as? String,
             let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(identifier)") else {
             throw VersionError.invalidBundleInfo
         }
         let data = try Data(contentsOf: url)
         guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
             throw VersionError.invalidResponse
         }
         if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
             return version != currentVersion
         }
         throw VersionError.invalidResponse
     }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
