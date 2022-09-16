//
//  NetworkManager.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.07.2022.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
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
                completion(nil, error?.localizedDescription)
            }
            else {
                do {
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    let apiResponse = try JSONDecoder().decode(CitySearchModel.self, from: responseData)
                    completion(apiResponse,nil)
                } catch { }
            }
        }
    }
    
//    func getAnnualTime(cityId: Int,  completion: @escaping (_ data: AnnualTimes?, _ error: String?)->()) {
//
//
//    }

    func yearTimes(cityId: Int, completion: @escaping (_ data: AnnualTime?, _ error: String?)->()) {
        router.request(.yearTimes(cityId: cityId)) {data, response, error in

            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            else {
                guard let responseData = data else {
                    completion(nil, NetworkResponse.noData.rawValue)
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(AnnualTime.self, from: responseData)
                    completion(apiResponse,nil)
                } catch {
                    completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
            }
        }
    }

    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
