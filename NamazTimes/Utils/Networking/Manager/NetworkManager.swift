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

    func searchCity(cityName: String, completion: @escaping (_ error: String?)->()) {
        router.request(.search(name: cityName)) { data, response, error in

            if error != nil {
                completion("Please check your network connection.")
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:

                    guard let responseData = data else {
                        completion(NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print("Response", String(data: responseData, encoding: .utf8))
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
                        completion(nil)
                    }catch {
                        print(error)
                        completion(NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(networkFailureError)
                }
            }
        }
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
