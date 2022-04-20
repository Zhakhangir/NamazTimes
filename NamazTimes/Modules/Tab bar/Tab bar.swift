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
        navigationController?.title = "Namaz Times"
        setupChilds()

    }

    private func setupChilds() {
        viewControllers = [
            createNavController(with: HomeViewController(),image: UIImage(named: "home")),
            createNavController(with: DayArticleViewController(),image: UIImage(named: "more")),
            createNavController(with: CompassViewController(), image: UIImage(named: "compass")),
            createNavController(with: SettingsViewController(), image: UIImage(named: "settings"))
        ]
    }

    private func createNavController( with rootViewController: UIViewController,
                                      title: String = "",
                                      image: UIImage?) -> UIViewController {

        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image

        return navController
    }
}
