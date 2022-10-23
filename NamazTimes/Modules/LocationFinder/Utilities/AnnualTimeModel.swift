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
class CityInfo: EmbeddedObject, Codable {
    @Persisted var cityName: String?
    @Persisted var Latitude: String?
    @Persisted var Latitude_1: String?
    @Persisted var Longitude: String?
    @Persisted var Longitude_1: String?
    @Persisted var QiblaDir: String?
    @Persisted var MagnetDev: String?
    @Persisted var TimeZone: String?
}

// MARK: - Day
class PreyerTimes: EmbeddedObject, Codable {
    @Persisted var imsak: String?
    @Persisted var bamdat: String?
    @Persisted var kun: String?
    @Persisted var ishraq: String?
    @Persisted var kerahat: String?
    @Persisted var besin: String?
    @Persisted var asriauual: String?
    @Persisted var ekindi: String?
    @Persisted var isfirar: String?
    @Persisted var aqsham: String?
    @Persisted var ishtibaq: String?
    @Persisted var quptan: String?
    @Persisted var ishaisani: String?
    @Persisted var day: String?
    @Persisted var dayName: String?
    @Persisted var date: String?
    @Persisted var islamicDateInWords: String?
    @Persisted var islamicDate: String?
}
