//
//  Tab bar.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit

class GeneralTabBarViewController: UITabBarController {
    
    private let navigationView = GeneralNavigationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = GeneralColor.primary
        tabBar.layer.borderColor = GeneralColor.primary.cgColor

        setupChilds()
        configureHeaderView()
    }

    private func configureHeaderView() {
        view.addSubview(navigationView)
        navigationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showLocationDetail)))
        navigationView.translatesAutoresizingMaskIntoConstraints = false

        navigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func setupChilds() {
        viewControllers = [
            createTabBarController(with: HomeRouter().build(), title: "Home",  image: UIImage(named: "clock")),
            createTabBarController(with: DailyTimesRouter().build(), title: "Daily times", image: UIImage(named: "calendar")),
            createTabBarController(with: QFCompassRouter().build(), title: "Compass", image: UIImage(named: "compass"))
        ]
    }

    private func createTabBarController( with rootViewController: UIViewController,
                                         title: String = "",
                                         image: UIImage?) -> UIViewController {

        rootViewController.tabBarItem.title = title
        rootViewController.tabBarItem.image = image

        return rootViewController
    }

   @objc private func showLocationDetail() {
       let alertVc = GeneralAlertPopupVc()
       let model = GeneralAlertModel(titleLabel: "Аlmaty", buttonTitle: "OK")
       let alertView = GeneralAlertPopupView()
       alertView.configure(with: model)
       alertVc.setContentView(alertView)

       present(alertVc, animated: true, completion: nil)
    }
}
