//
//  AnnualTimesModel.swift
//  Namaz Times
//
//  Created by &&TairoV on 08.08.2022.
//

import Foundation
import RealmSwift

// MARK: - AnnualTime
class AnnualTime: Codable {
    var cityname: String?
    var dailyTimes: [DailyTime]?

    private struct DynamicCodingKeys: CodingKey {

        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var decodedArray = [DailyTime]()
        var decodedCityName: String?

        for key in container.allKeys {
            let keyString = key.stringValue
            if keyString == "cityname" {
                decodedCityName = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: keyString)!)
            } else {
                let decodedObject = try container.decode(DailyTime.self, forKey: DynamicCodingKeys(stringValue: keyString)!)
                decodedObject.date = keyString
                decodedArray.append(decodedObject)
            }
        }

        dailyTimes = decodedArray
        cityname = decodedCityName
    }
}

// MARK: - DailyTime
class DailyTime: Object, Codable {
    @objc var imsak, bamdat, kun, ishraq: String?
    @objc var kerahat, besin, asriauual, ekindi: String?
    @objc var isfirar, aqsham, ishtibaq, quptan: String?
    @objc var ishaisani, day, week, date: String?
}
