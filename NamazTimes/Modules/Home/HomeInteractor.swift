//
//  HomeInterator.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation
import RealmSwift

enum PrayerTimes { }

protocol HomeInteractorInput {
    func getAnnualTimes() -> YearTimes?
    func getTimesList() -> [PrayerTimesList]
}

class HomeInteractor: HomeInteractorInput {

    var view: HomeViewInput
    private let realm = try! Realm()
    private var annualTimes: [YearTimes]

    private let dailyTimes: [PrayerTimesList] = [
        .init(name: "Имсак", time: "3:02", show: true),
        .init(name: "Бамдат", time: "3:22", show: true),
        .init(name: "Күн", time: "5:24", show: true),
        .init(name: "Бесін", time: "13:09", show: true),
        .init(name: "Екінді", time: "18:22", show: true),
        .init(name: "Ақшам", time: "20:34", show: true),
        .init(name: "Құптан", time: "22:36", show: true)
    ]

    init(view: HomeViewInput) {
        self.view = view
        self.annualTimes = realm.objects(YearTimes.self).toArray(ofType: YearTimes.self)
    }

    func getAnnualTimes() -> YearTimes? {
        return annualTimes.first
    }

    func getTimesList() -> [PrayerTimesList] {
        return dailyTimes
    }
}
