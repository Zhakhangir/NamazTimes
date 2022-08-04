//
//  NetworkError.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.07.2022.
//

import Foundation

enum NetworkError: String, Error {
    case parametersNil = "Parameters where nil."
    case encodingFailed = "Parameter encoding failed."
    case missingUrl = "URL is nil"
}
