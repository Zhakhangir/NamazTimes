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
    func getQiblaAngle() -> String
}

class QFCompassInteractor: QFCompassInteractorInput {
    
    var view: QFCompassViewInput
    private var qiblaAngle: Double = 0.0

    let cityInfo = GeneralStorageController.shared.getCityInfo()
    
    init(view: QFCompassViewInput) {
        
        
        qiblaAngle = (Double((cityInfo?.QiblaDir ?? "0.0")) ?? 0.0)
        print("Qibla Dir", qiblaAngle)
        self.view = view
    }

    func getDirectionOfKabah(heading: CLHeading) -> CGFloat {
        let north = -1 * heading.magneticHeading * Double.pi/180
        let directionOfKabah = qiblaAngle * Double.pi/180 + north
        return directionOfKabah
    }
    
    func getQiblaAngle() -> String {
        return cityInfo?.QiblaDir ?? ""
    }
}
