//
//  Home view controller.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit

class HomeViewController: GeneralViewController {
    
    let layerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Layer", for: .normal)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addSubviews()
        setupLayout()
        stylize()
    }

    private func addSubviews() {
        contentView.addSubview(layerButton)
    }

    private func setupLayout() {
        var layoutConstraints = [NSLayoutConstraint]()
        
        layerButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            layerButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            layerButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            layerButton.heightAnchor.constraint(equalToConstant: 48),
            layerButton.widthAnchor.constraint(equalToConstant: 100)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        layerButton.addTarget(self, action: #selector(showLayer), for: .touchUpInside)
    }

    @objc private func showLayer() {
        LoadingLayer.shared.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            LoadingLayer.shared.hide()
        }
    }
}
