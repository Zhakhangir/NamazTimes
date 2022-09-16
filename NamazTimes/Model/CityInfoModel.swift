//
//  CityInfoModel.swift
//  Namaz Times
//
//  Created by &&TairoV on 08.09.2022.
//

import Foundation
import RealmSwift

// MARK: - AnnualTimes
struct AnnualTimes: Codable {
    let attributes: CityInfo?
    let days: [Days]?
}

// MARK: - CityInfo
struct CityInfo: Codable {
    let id, countryID, timezone, cityName: String?
    let latitude1, latitude2, latitude3, longitude1: String?
    let longitude2, longitude3, qiblaDir, magnetDev: String?
    let timeZone: String?
}

// MARK: - Day
struct Days: Codable {
    let imsak, bamdat, kun, ishraq: String?
    let kerahat, besin, asriauual, ekindi: String?
    let isfirar, aqsham, ishtibaq, quptan: String?
    let ishaisani, day, dayName, date: String?
    let islamicDateInWords, islamicDate: String?
}

