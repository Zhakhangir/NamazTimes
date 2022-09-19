//
//  NetworkManager.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.07.2022.
//

import Foundation

enum NetworkResponse:String {
    case success, authenticationError, badRequest, outdated, failed, noData, unableToDecode, timeOut
    
    var value: String {
        switch self {
        case .success:
            return  "success"
        case .authenticationError:
            return "auth"
        case .badRequest:
            return "bad_reques".localized
        case .outdated:
            return "The url you requested is outdated."
        case .failed:
            return "bad_request".localized
        case .noData:
            return "no_data".localized
        case .unableToDecode:
            return "decode_error".localized
        case .timeOut:
            return "time_out".localized
        }
    }
}

enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager {
    static let environment : NetworkEnvironment = .production
    static let MovieAPIKey = ""
    let router = Router<PrayerTimesApi>()

    func searchCity(cityName: String, completion: @escaping (_ data: CitySearchModel?, _ error: String?)->()) {
        router.request(.search(name: cityName)) { data, response, error in

            if error != nil {
                completion(nil, NetworkResponse.timeOut.value)
            }
            else {
                do {
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.value)
                        return
                    }
                    let apiResponse = try JSONDecoder().decode(CitySearchModel.self, from: responseData)
                    completion(apiResponse,nil)
                } catch { }
            }
        }
    }

    func annualTimes(cityId: Int, completion: @escaping (_ data: CityData?, _ error: String?)->()) {
        router.request(.annualTimes(cityId: cityId)) {data, response, error in

            if error != nil {
                completion(nil, NetworkResponse.timeOut.value)
            }
            else {
                guard let responseData = data else {
                    completion(nil, NetworkResponse.noData.value)
                    return
                }
                do {
                    print(String(data: responseData, encoding: .utf8), data)
                    let apiResponse = try JSONDecoder().decode(CityData.self, from: responseData)
                    completion(apiResponse,nil)
                } catch {
                    completion(nil, NetworkResponse.unableToDecode.value)
                }
            }
        }
    }

    private func handleNetworkResponse(_ response: HTTPURLResponse) -> String{
        switch response.statusCode {
        case 200...299: return NetworkResponse.success.value
        case 401...500: return NetworkResponse.authenticationError.value
        case 501...599: return NetworkResponse.badRequest.value
        case 600: return NetworkResponse.outdated.value
        default: return NetworkResponse.failed.value
        }
    }
}
