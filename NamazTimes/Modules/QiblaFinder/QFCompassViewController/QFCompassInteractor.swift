//
//  CompassInteractor.swift
//  NamazTimes
//
//  Created by &&TairoV on 27.05.2022.
//

import UIKit
import CoreLocation

protocol QFCompassInteractorInput {
    func getDirectionOfKabah(heading: CLHeading) -> CGFloat
}

class QFCompassInteractor: QFCompassInteractorInput {

    var view: QFCompassViewInput
    private let qiblaAngle = 247.0

    init(view: QFCompassViewInput) {
        self.view = view
    }

    func getDirectionOfKabah(heading: CLHeading) -> CGFloat {
        let north = -1 * heading.magneticHeading * Double.pi/180
        let directionOfKabah = qiblaAngle * Double.pi/180 + north
        return directionOfKabah
    }
}
