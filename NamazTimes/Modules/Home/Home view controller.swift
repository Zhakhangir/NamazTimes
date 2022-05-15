//
//  Home view controller.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(btn)

        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .green
        btn.setTitle("Layer", for: .normal)

        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btn.heightAnchor.constraint(equalToConstant: 48),
            btn.widthAnchor.constraint(equalToConstant: 100)
        ])

        btn.addTarget(self, action: #selector(showLayer), for: .touchUpInside)
        
    }

    @objc private func showLayer() {
        LoadingLayer.shared.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            LoadingLayer.shared.hide()
        }
    }
}
