//
//  GeneralViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 5/14/22.
//

import UIKit
import Lottie

class GeneralViewController: UIViewController {

    var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureContent()
    }

    private func configureContent() {
        view.addSubview(contentView)

        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 11.0, *) {
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 85).isActive = true
        } else {
            contentView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 85).isActive = true
        }

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)

        ])
    }
}
