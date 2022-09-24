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
        
        tabBar.layer.borderColor = GeneralColor.primary.cgColor
        

        setupChilds()
        configureSubviews()
        stylize()
        addActions()
    }
    
    convenience init(selectedIndex: Int?) {
        self.init(nibName: nil, bundle: nil)
        
        guard let selectedIndex = selectedIndex else {  return }
        self.selectedIndex = selectedIndex
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
            createTabBarController(with: HomeRouter().build(), title: "interval".localized,  image: UIImage(named: "clock")),
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

   @objc private func showLocationSettings() {

       let vc = LocationFinderRouter().build()
       vc.modalPresentationStyle = .fullScreen
       present(vc, animated: true, completion: nil)
    }
    
    private func addActions() {
        navigationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showLocationSettings)))
    }
    
    private func stylize() {
    
    }
}
