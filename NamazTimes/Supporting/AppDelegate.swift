//
//  AppDelegate.swift
//  NamazTimes
//
//  Created by &&TairoV on 3/31/22.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var locationManager = LocationMen()
    var currentCityData = "Almaty"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window

        locationManager.checkLocationAccess()
        configureRoot()

        return true
    }

    func configureRoot() {
        switch locationManager.status {
        case .restricted:
            print("Show alert error")
        case .denied:
            window?.rootViewController = LocationSettingsViewController()
        case .authorizedAlways, .authorizedWhenInUse:
            window?.rootViewController = TabBar()
        @unknown default:
            return
        }


    }
}

extension AppDelegate: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        configureRoot()
    }
}
