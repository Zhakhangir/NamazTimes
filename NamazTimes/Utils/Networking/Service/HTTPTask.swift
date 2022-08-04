//
//  HTTPTask.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.07.2022.
//

import Foundation

public typealias HTTPHeaders = [String:String]

enum HTTPTask {
    case request
    case requestParameters(bodyParameter: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameter: Parameters?,
                                     urlParameters: Parameters?,
                                     additionHeaders: HTTPHeaders?)
}
