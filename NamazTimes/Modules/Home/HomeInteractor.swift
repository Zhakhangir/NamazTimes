//
//  HomeInterator.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation

enum PrayerTimes {
    
}

protocol HomeInteractorInput { }

class HomeInteractor: HomeInteractorInput {
    
    var view: HomeViewInput

    init(view: HomeViewInput) {
        self.view = view
    }
}
