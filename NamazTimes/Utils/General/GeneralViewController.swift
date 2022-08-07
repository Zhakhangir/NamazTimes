//
//  GeneralViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 5/14/22.
//

import UIKit
import Lottie

class GeneralViewController: UIViewController, GeneralViewControllerProtocol {

    var timer = Timer()
    var localDate: Date { Date() }
    var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureContent()
        runTimer()
    }

    private func configureContent() {
        view.addSubview(contentView)

        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 11.0, *) {
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 85).isActive = true
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            contentView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 85).isActive = true
            contentView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
        }

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)

        ])
    }

    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(secondRefresh), userInfo: nil, repeats: true)
        timer.fire()
        RunLoop.current.add(timer, forMode: .default)
    }

    

    @objc public func secondRefresh() { }
}
