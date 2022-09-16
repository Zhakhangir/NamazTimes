//
//  DailyTimesInteractor.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation
import RealmSwift

protocol DailyTimesInteractorInput {
    func getData() -> [PrayerTimesList]
    func didChageSwitch(for index: IndexPath, to value: Bool)
}

struct PrayerTimesList {
    var name: String?
    var time: String?
    var isHidden: Bool = false
}

class DailyTimesInteractor: DailyTimesInteractorInput {

    var view: DailyTimesViewInput
    private var prayerTimesSettings = PrayerTimesListSettings()
    private var timesList = [PrayerTimesList]()
    private var dailyTime = DailyTime()
    private let realm = try! Realm()

    init(view: DailyTimesViewInput) {
        self.view = view
        
        prayerTimesSettings = GeneralStorageController.shared.getPrayerTimesListSettings()
        dailyTime = GeneralStorageController.shared.getDailyTimes()
    }

    func getData() -> [PrayerTimesList] {
        timesList.removeAll()
        for (_, item) in prayerTimesSettings.prayerTimes.enumerated() {
            var listItem = PrayerTimesList()
            listItem.name = item.name.localized
            listItem.isHidden = item.isHidden
            listItem.time = dailyTime.value(forKey: item.name) as? String
            timesList.append(listItem)
        }
        return timesList
    }

    func didChageSwitch(for index: IndexPath, to value: Bool) {
        try! realm.write {
            prayerTimesSettings.prayerTimes[index.row].isHidden = !value
        }
    }
}
