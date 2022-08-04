//
//  ParameterEncoding.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.07.2022.
//

import Foundation

typealias Parameters = [String:Any]

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
