//
//  GeneralViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 5/14/22.
//

import UIKit
import Lottie

class GeneralViewController: UIViewController {

    private let navigationView = GeneralNavigationView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHeaderView()

    }

    private func configureHeaderView() {
        view.addSubview(navigationView)

        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
