//
//  LocationMan.swift
//  NamazTimes
//
//  Created by &&TairoV on 5/1/22.
//

import Foundation
import CoreLocation

class LocationMen {

    var locmen = CLLocationManager()

    var status: CLAuthorizationStatus {
        if #available(iOS 14.0, *) {
            return locmen.authorizationStatus
        } else {
            return CLLocationManager.authorizationStatus()
        }
    }

    func checkLocationAccess(successMethod: (()->Void)? = nil) {
        switch status {
        case .denied, .notDetermined:
            locmen.requestAlwaysAuthorization()
            locmen.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            successMethod?()
        case .restricted:
            print("restircted")
        @unknown default:
            print("error4")
        }
    }
}
