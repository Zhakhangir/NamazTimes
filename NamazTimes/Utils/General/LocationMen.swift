//
//  LocationMan.swift
//  NamazTimes
//
//  Created by &&TairoV on 5/1/22.
//

import Foundation
import CoreLocation

class LocationMen: NSObject {

    private var closure: ((Double?, Double?)->Void)?
    var locmen = CLLocationManager()

    var status: CLAuthorizationStatus {
        if #available(iOS 14.0, *) {
            return locmen.authorizationStatus
        } else {
            return CLLocationManager.authorizationStatus()
        }
    }

    override init() {

    }

    func getCurrentUserPosition(completion: @escaping (Double?, Double?) -> Void) {

        closure = completion
        DispatchQueue.main.async {
            self.locmen.requestAlwaysAuthorization()
        }
        locmen.delegate = self
        locmen.desiredAccuracy = kCLLocationAccuracyBest
        locmen.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            DispatchQueue.main.async {
                self.locmen.startUpdatingLocation()
            }
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

extension LocationMen: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations _: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        closure?(location.latitude, location.longitude)
        locmen.stopUpdatingLocation()
    }

}
