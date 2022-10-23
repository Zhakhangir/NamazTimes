//
//  LocationService.swift
//
//
//  Created by Anak Mirasing on 5/18/2558 BE.
//
//

//
//  LocationManager.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.07.2022.
//

import CoreLocation
import UIKit

protocol LocationServiceDelegate {
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: NSError)
    func tracingHeading(heading: CLHeading)
}

class LocationService: NSObject, CLLocationManagerDelegate {

    static var sharedInstance = LocationService()

    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var delegate: LocationServiceDelegate?

    var status: CLAuthorizationStatus {
        if #available(iOS 14.0, *) {
            return locationManager?.authorizationStatus ?? .denied
        } else {
            return CLLocationManager.authorizationStatus()
        }
    }

    private override init() {
        super.init()

        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }

        if CLLocationManager.authorizationStatus() == .notDetermined {
            // you have 2 choice
            // 1. requestAlwaysAuthorization
            // 2. requestWhenInUseAuthorization
            locationManager.requestAlwaysAuthorization()
        }

        locationManager.desiredAccuracy = kCLLocationAccuracyBest // The accuracy of the location data
        locationManager.distanceFilter = 1000 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
        locationManager.delegate = self
    }

    // Start Stop updating location
    func startUpdatingLocation() {
        print("Starting Location Updates")
        locationManager?.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        print("Stop Location Updates")
        locationManager?.stopUpdatingLocation()
    }


    // Start Stop updating heading
    func startUpdatingHeading() {
        print("Starting Location Updates")
        locationManager?.startUpdatingHeading()
    }

    func stopUpdatingHeading() {
        print("Stop Location Updates")
        locationManager?.stopUpdatingHeading()
    }

    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else { return }

        // singleton for get last(current) location
        self.currentLocation = location

        // use for real time update location
        updateLocation(currentLocation: location)
    }

    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {

        // do on error
        updateLocationDidFailWithError(error: error)
    }

    // Private function
    private func updateLocation(currentLocation: CLLocation){

        guard let delegate = self.delegate else {
            return
        }

        delegate.tracingLocation(currentLocation: currentLocation)
    }

    private func updateLocationDidFailWithError(error: NSError) {

        guard let delegate = self.delegate else {
            return
        }

        delegate.tracingLocationDidFailWithError(error: error)
    }
}

extension LocationService {

    func getConfiguredRoot() -> UIViewController {
        var vc = UIViewController()

        switch status {
        case .notDetermined, .denied, .restricted:
            vc = ErrorPageViewController()
        case .authorizedAlways, .authorizedWhenInUse:
            vc = GeneralStorageController.shared.getCityInfo() == nil ? LocationFinderRouter().build() : GeneralTabBarViewController()
        default: vc = ErrorPageViewController()
        }

        return vc
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        UIApplication.shared.keyWindow?.rootViewController = getConfiguredRoot()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        delegate?.tracingHeading(heading: newHeading)
    }
}
