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
    func getAnnualTimes() -> [DailyTime]?
}

class HomeInteractor: HomeInteractorInput {

    var view: HomeViewInput
    private let realm = try! Realm()
    private var annualTimes: [DailyTime]

    init(view: HomeViewInput) {
        self.view = view
        self.annualTimes = realm.objects(YearTimes.self).toArray(ofType: DailyTime.self)
    }

    func getAnnualTimes() -> [DailyTime]? {
        return annualTimes
    }
}
