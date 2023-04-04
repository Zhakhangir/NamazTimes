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
    private let realm = try! Realm()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window

        print(realm.configuration.fileURL)
        LocationService.sharedInstance.startUpdatingLocation()
        configure()

        return true
    }

    func configure() {
        
        if UserDefaults.standard.string(forKey: "language") == nil {
            UserDefaults.standard.set(LanguageHelper().code, forKey: "language")
            UserDefaults().synchronize()
        }
    
        window?.rootViewController =  LocationService.sharedInstance.getConfiguredRoot()
    }
}
