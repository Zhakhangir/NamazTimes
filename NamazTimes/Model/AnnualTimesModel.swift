//
//  AnnualTimesModel.swift
//  Namaz Times
//
//  Created by &&TairoV on 08.08.2022.
//

import Foundation
import RealmSwift

// MARK: - AnnualTime
struct AnnualTime: Codable {
    var cityname: String?
    var dailyTimes: [DailyTime]?

    private struct DynamicCodingKeys: CodingKey {

        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }

    init(from decoder: Decoder) throws {
        // 1
        // Create a decoding container using DynamicCodingKeys
        // The container will contain all the JSON first level key
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var decodedArray = [DailyTime]()
        var decodedCityName: String?
        // 2
        // Loop through each key (student ID) in container
        for key in container.allKeys {
            // Decode Student using key & keep decoded Student object in tempArray
            do {
                let keyString = key.stringValue
                if keyString == "cityname" {
                    decodedCityName = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: keyString)!)
                } else {
                   let decodedObject = try container.decode(DailyTime.self, forKey: DynamicCodingKeys(stringValue: keyString)!)
                    decodedObject.date = keyString
                    decodedArray.append(decodedObject)
                }

            } catch {
                print(error)
            }
        }
        // 3
        // Finish decoding all Student objects. Thus assign tempArray to array.
        dailyTimes = decodedArray
        cityname = decodedCityName
    }
}

class TestClass: Codable {
    var cityname: String?
    var dailyTimes: [DailyTime]?
}

// MARK: - DailyTime
class DailyTime: Object, Codable {
    @objc var imsak, bamdat, kun, ishraq: String?
    @objc var kerahat, besin, asriauual, ekindi: String?
    @objc var isfirar, aqsham, ishtibaq, quptan: String?
    @objc var ishaisani, day, week, date: String?
}
