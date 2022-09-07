//
//  GeneralStorage.swift
//  NamazTimes
//
//  Created by &&TairoV on 14.07.2022.
//

import Foundation
import RealmSwift

class YearTimes: Object {
    @Persisted var cityName: String = ""
    @Persisted var times = List<DailyTime>()
}
