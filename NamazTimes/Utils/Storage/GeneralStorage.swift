//
//  GeneralStorage.swift
//  NamazTimes
//
//  Created by &&TairoV on 14.07.2022.
//

import Foundation
import RealmSwift

//class GeneralStorage: Object {
//    @objc var name: String = ""
//    @objc var owner: String = ""
//    @objc var status: Bool = false
//
//    init(name: String, owner: String, status: Bool) {
//        self.name = name
//        self.owner = owner
//        self.status = status
//    }
//}

class YearTimes: Object {
    @Persisted var yaerTimes = List<DailyTime>()
}
