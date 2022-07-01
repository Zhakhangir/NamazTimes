//
//  HomeInterator.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import Foundation

class HomeInteractor: HomeInteratorInput {
    
    var view: HomeViewInput

    init(view: HomeViewInput) {
        self.view = view
    }
}
