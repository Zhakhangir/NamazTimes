//
//  CompassViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit

class QFCompassViewController: GeneralViewController {

    var router: QFCompassRouterInput?
    var interactor: QFCompassInteractorInput?

    private var mapView =  MapQiblaFinderView()

    private var mapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "mapLocation"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addSubviews()
        setupLayout()
        stylize()
        addActions()
    }

    private func addSubviews() {
        contentView.addSubview(mapButton)
    }

    private func setupLayout() {
        var layoutConstraints = [NSLayoutConstraint]()

        mapButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            mapButton.heightAnchor.constraint(equalToConstant: 30),
            mapButton.widthAnchor.constraint(equalToConstant: 30),
            mapButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            mapButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        modalPresentationStyle = .currentContext
    }

    private func addActions() {
        mapButton.addTarget(self, action: #selector(showMap), for: .touchUpInside)
    }
}

extension QFCompassViewController: QFCompassViewInput {

}

extension QFCompassViewController {

    @objc private func showMap() {
        router?.showQFMap()
    }
}
