//
//  Tab bar.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = GeneralColor.primary
        tabBar.layer.borderColor = GeneralColor.primary.cgColor
        navigationController?.title = "Namaz Times"
        setupChilds()

    }

    private func setupChilds() {
        viewControllers = [
            createTabBarController(with: HomeViewController(), title: "home",  image: UIImage(named: "home")),
            createTabBarController(with: DayArticleViewController(), title: "location", image: UIImage(named: "more")),
            createTabBarController(with: CompassViewController(), title: "compass", image: UIImage(named: "compass")),
            createTabBarController(with: SettingsViewController(), title: "settings", image: UIImage(named: "settings"))
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
