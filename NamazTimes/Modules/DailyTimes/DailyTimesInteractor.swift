//
//  DailyTimesInteractor.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation


protocol DailyTimesInteractorInput {}

struct PrayerTimesList {
    var name: String?
    var time: String?
    var show: Bool = false
    var isSelected: Bool = false
}

class DailyTimesInteractor: DailyTimesInteractorInput {

    var view: DailyTimesViewInput

    init(view: DailyTimesViewInput) {
        self.view = view
    }
}
