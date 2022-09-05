//
//  AppDelegate.swift
//  NamazTimes
//
//  Created by &&TairoV on 3/31/22.
//

import UIKit
import CoreLocation
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var currentCityData = UserDefaults.standard.string(forKey: "currentCity")
    lazy var realm = try? Realm()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window

        print(realm?.configuration.fileURL?.path)
        LocationService.sharedInstance.delegate = self
        LocationService.sharedInstance.startUpdatingLocation()
        configureRoot()
        
        return true
    }

    func configureRoot() {
        switch LocationService.sharedInstance.status {
        case .notDetermined, .denied, .restricted:
            window?.rootViewController = LocationAccessErrorViewController()
        case .authorizedAlways, .authorizedWhenInUse:
            window?.rootViewController = GeneralTabBarViewController()
        default: return
        }
    }
}

extension AppDelegate: LocationServiceDelegate {

    func tracingLocation(currentLocation: CLLocation) {
        configureRoot()
    }

    func tracingLocationDidFailWithError(error: NSError) { }

    func tracingHeading(heading: CLHeading) { }
}
