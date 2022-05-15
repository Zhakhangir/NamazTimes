//
//  Tab bar.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit

class TabBar: UITabBarController {

    private let navigationView = GeneralNavigationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = GeneralColor.primary
        tabBar.layer.borderColor = GeneralColor.primary.cgColor
        navigationController?.title = "Namaz Times"
        setupChilds()
        configureHeaderView()

    }

    private func configureHeaderView() {
        view.addSubview(navigationView)

        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func setupChilds() {
        viewControllers = [
            createTabBarController(with: HomeViewController(), title: "Home",  image: UIImage(named: "home")),
            createTabBarController(with: DailyTimesListViewController(), title: "Daily times", image: UIImage(named: "calendar_1")),
            createTabBarController(with: CompassViewController(), title: "Compass", image: UIImage(named: "compass"))
        ]
    }

    private func createTabBarController( with rootViewController: UIViewController,
                                         title: String = "",
                                         image: UIImage?) -> UIViewController {

        rootViewController.tabBarItem.title = title
        rootViewController.tabBarItem.image = image

        return rootViewController
    }
}
