//
//  QFMapIntractorInput.swift
//  NamazTimes
//
//  Created by &&TairoV on 30.05.2022.
//

import Foundation
import CoreLocation

protocol QFMapInteractorInput {
    func getUserLocation() -> CLLocationCoordinate2D
}
