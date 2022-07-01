//
//  DailyTimesInteractor.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation

struct NamazTimesList {
    var name: String
    var time: String
    var isOn: Bool
}

class DailyTimesInteractor: DailyTimesInteractorInput {

    var view: DailyTimesViewInput

    init(view: DailyTimesViewInput) {
        self.view = view
    }
}
