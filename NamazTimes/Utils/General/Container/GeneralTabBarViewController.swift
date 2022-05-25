//
//  Tab bar.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit

class GeneralTabBarViewController: UITabBarController {

    private let navigtionView = GeneralNavigationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = GeneralColor.primary
        tabBar.layer.borderColor = GeneralColor.primary.cgColor
        modalTransitionStyle = .coverVertical
        modalPresentationStyle = .fullScreen

        setupChilds()
        configureHeaderView()
    }

    private func configureHeaderView() {
        view.addSubview(navigtionView)
        navigtionView.translatesAutoresizingMaskIntoConstraints = false

        navigtionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigtionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigtionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func setupChilds() {
        viewControllers = [
            createTabBarController(with: HomeViewController(), title: "Home",  image: UIImage(named: "clock")),
            createTabBarController(with: DailyTimesListViewController(), title: "Daily times", image: UIImage(named: "calendar")),
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
