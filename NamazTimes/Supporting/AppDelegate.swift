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
        }
    
        window?.rootViewController =  LocationService.sharedInstance.getConfiguredRoot()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("1")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("2")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("3")
//        LoadingLayer.shared.show()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            LoadingLayer.shared.hide()
//        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("4")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("5")
    }
}
