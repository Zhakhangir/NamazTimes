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

        setupChilds()
        configureHeaderView()
    }
    
    convenience init(selectedIndex: Int?) {
        self.init(nibName: nil, bundle: nil)
        
        guard let selectedIndex = selectedIndex else {  return }
        self.selectedIndex = selectedIndex
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
            createTabBarController(with: HomeRouter().build(), title: "interval".localized,  image: UIImage(named: "clock")),
            createTabBarController(with: DailyTimesRouter().build(), title: "daily_times".localized, image: UIImage(named: "calendar")),
            createTabBarController(with: QFCompassRouter().build(), title: "qibla_st".localized, image: UIImage(named: "compass")),
            createTabBarController(with: SettingsRouter().build(), title: "settings".localized, image: UIImage(named: "settings"))
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
    }
    
    func configure(with viewModel: CityInfo) {
        navigationView.configure(with: viewModel)
    }
}
