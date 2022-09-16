//
//  PrayerTimesModel.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.07.2022.
//

import Foundation

struct CitySearchModel: Codable {
    let results: [Regions]?
}

struct Regions: Codable {
    let text: String?
    let children: [RegionCities]?
}

struct RegionCities: Codable {
    let id: Int?
    let text: String?
}
