//
//  GeneralStorage.swift
//  NamazTimes
//
//  Created by &&TairoV on 14.07.2022.
//

import Foundation
import RealmSwift

class CityPrayerData: Object {
    @objc dynamic var cityInfo: CityInfo?
    var times = List<PreyerTimes>()
    
    required convenience init(data: CityData) {
        self.init()
        self.cityInfo = data.attributes
        self.times.append(objectsIn: data.days ?? [PreyerTimes]())
    }
}
