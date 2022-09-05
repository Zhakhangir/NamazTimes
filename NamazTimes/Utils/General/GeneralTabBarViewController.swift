//
//  Tab bar.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit
import CoreLocation

class GeneralTabBarViewController: UITabBarController {
    
    let navigationView = GeneralNavigationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = GeneralColor.primary
        tabBar.layer.borderColor = GeneralColor.primary.cgColor

        LocationService.sharedInstance.delegate = self
        LocationService.sharedInstance.startUpdatingLocation()
        setupChilds()
        configureHeaderView()
    }

    private func configureHeaderView() {
        view.addSubview(navigationView)
        navigationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showLocationSettings)))
        navigationView.translatesAutoresizingMaskIntoConstraints = false

        navigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func setupChilds() {
        viewControllers = [
            createTabBarController(with: HomeRouter().build(), title: "Home",  image: UIImage(named: "clock")),
            createTabBarController(with: DailyTimesRouter().build(), title: "Daily times", image: UIImage(named: "calendar")),
            createTabBarController(with: QFCompassRouter().build(), title: "Compass", image: UIImage(named: "compass")),
            createTabBarController(with: SettingsRouter().build(), title: "Settings", image: UIImage(named: "settings"))
        ]
    }

    private func createTabBarController( with rootViewController: UIViewController,
                                         title: String = "",
                                         image: UIImage?) -> UIViewController {

        rootViewController.tabBarItem.title = title
        rootViewController.tabBarItem.image = image

        return rootViewController
    }

   @objc private func showLocationSettings() {

       let vc = LocationFinderRouter().build()
       vc.modalPresentationStyle = .fullScreen
       present(vc, animated: true, completion: nil)


//              guard let window = UIApplication.shared.keyWindow else { return }
//              window.rootViewController = vc
//       UIView.transition(with: window,
//                             duration: 0.3,
//                             options: .transitionCrossDissolve,
//                             animations: nil,
//                             completion: nil)
//       let alertVc = GeneralAlertPopupVc()
//       let model = GeneralAlertModel(titleLabel: "Аlmaty", buttonTitle: "OK")
//       let alertView = GeneralAlertPopupView()
//       alertView.configure(with: model)
//       alertVc.setContentView(alertView)
//
//       present(alertVc, animated: true, completion: nil)
    }
}

extension GeneralTabBarViewController: LocationServiceDelegate {

    func tracingLocation(currentLocation: CLLocation) {
        navigationView.titleLabel.text = currentLocation.getLongLatString()
    }

    func tracingLocationDidFailWithError(error: NSError) {

    }

    func tracingHeading(heading: CLHeading) {

    }
}
