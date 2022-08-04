//
//  Router.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.07.2022.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {

    private var task: URLSessionTask?

    func request(_ route: EndPoint, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let session = URLSession.shared

        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, responce, error in
                completion(data, responce, error)
            })
        } catch {
            completion(nil, nil, error)
        }

        task?.resume()
    }

    func cancel() {
        task?.cancel()
    }

    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod?.rawValue

        do {
            switch route.task ?? .request {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let urlParameters):
                try configureParameteres(bodyParameters: bodyParameters,
                                         urlParameters: urlParameters,
                                         request: &request)
            case .requestParametersAndHeaders(let bodyParameter,
                                              let urlParameters,
                                              let additionHeaders):
                additionalHeaders(additionHeaders, request: &request)
                try configureParameteres(bodyParameters: bodyParameter,
                                         urlParameters: urlParameters,
                                         request: &request)
            }
            return request
        } catch {
            throw error
        }
    }

    private func configureParameteres(bodyParameters: Parameters?,
                                      urlParameters: Parameters?,
                                      request: inout URLRequest) throws {

        do {
            if let params = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: params)
            }

            if let params = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: params)
            }
        } catch {
            throw error
        }
    }

    func additionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(key, forHTTPHeaderField: value)
        }
    }

}
