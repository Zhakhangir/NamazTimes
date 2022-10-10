//
//  CityInfoModel.swift
//  Namaz Times
//
//  Created by &&TairoV on 08.09.2022.
//

import Foundation
import RealmSwift

// MARK: - AnnualTimes
class CityData: Codable {
    var attributes: CityInfo?
    var days: [PreyerTimes]?
}

// MARK: - CityInfo
class CityInfo: Object, Codable {
    @objc dynamic var cityName, Latitude, Latitude_1, Longitude: String?
    @objc dynamic var Longitude_1, QiblaDir, MagnetDev, TimeZone: String?
}

// MARK: - Day
class PreyerTimes: Object, Codable {
    @objc dynamic var imsak, bamdat, kun, ishraq: String?
    @objc dynamic var kerahat, besin, asriauual, ekindi: String?
    @objc dynamic var isfirar, aqsham, ishtibaq, quptan: String?
    @objc dynamic var ishaisani, day, dayName, date: String?
    @objc dynamic var islamicDateInWords, islamicDate: String?
}
