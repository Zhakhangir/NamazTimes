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
        
        view.backgroundColor = GeneralColor.backgroundGray
        navigationView.delegate = self
        
        setupChilds()
        configureSubviews()
        configure()
    }
    
    convenience init(selectedIndex: Int?) {
        self.init(nibName: nil, bundle: nil)
        
        guard let selectedIndex = selectedIndex else {  return }
        self.selectedIndex = selectedIndex
    }
    
    private func configure() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func configureSubviews() {
        
        view.addSubview(navigationView)
        var layoutConstraints = [NSLayoutConstraint]()
        
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            navigationView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    private func setupChilds() {
        viewControllers = [
            createTabBarController(with: MainPageRouter().build(), title: "times".localized,  image: UIImage(named: "clock")),
            createTabBarController(with: QFCompassRouter().build(), title: "qibla_st".localized, image: UIImage(named: "compass"))
        ]
    }
    
    private func createTabBarController( with rootViewController: UIViewController,
                                         title: String = "",
                                         image: UIImage?) -> UIViewController {
        
        rootViewController.tabBarItem.title = title
        rootViewController.tabBarItem.image = image
        
        return rootViewController
    }
    
    func routeToLocationSettings() {
        let vc = LocationFinderRouter(hideCloseButton: false).build()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func routeToSettings(animate: Bool = false) {
        let vc = SettingsRouter().build()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: animate, completion: nil)
    }
}

extension GeneralTabBarViewController: NavigationButtonDelegate {
    func didTapButton(type: NavigationButton) {
        switch type {
        case .location:
            routeToLocationSettings()
        case .settings:
            routeToSettings(animate: true)
        }
    }
}
