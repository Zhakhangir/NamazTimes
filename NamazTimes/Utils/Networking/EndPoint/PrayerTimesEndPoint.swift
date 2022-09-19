//
//  PrayerTimesEndPOint.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.07.2022.
//

import UIKit

enum PrayerTimesApi {
    case annualTimes(cityId: Int)
    case autoFinder(long: CGFloat, lat: CGFloat)
    case search(name: String)
}

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

extension PrayerTimesApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://namaztimes.kz"
        case .qa: return "https://namaztimes.kz"
        case .staging: return "https://namaztimes.kz"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .annualTimes:
            return "api/year-times"
        case .autoFinder:
            return "/year-times/8408 year"
        case .search:
            return "/json/sity"
            
        }
    }
    
    var httpMethod: HTTPMethod? {
        return .get
    }
    
    var task: HTTPTask? {
        switch self {
        case .annualTimes(let cityId):
            return .requestParameters(bodyParameter: nil, urlParameters: ["cityId": cityId])
        case .search(let name):
            return .requestParameters(bodyParameter: nil, urlParameters: ["q": name])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
