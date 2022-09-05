//
//  CompassViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit
import CoreLocation

protocol QFCompassViewInput: GeneralViewControllerProtocol {}

class QFCompassViewController: GeneralViewController {

    var router: QFCompassRouterInput?
    var interactor: QFCompassInteractorInput?
    let locationService = LocationService.sharedInstance

    private var mapView =  QFMapView()
    private let arrowView = QFArrowView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(dynamicSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()

    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.font = .systemFont(dynamicSize: 14, weight: .regular)
        textView.textColor = .black
        return textView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, messageTextView])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

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

        locationService.delegate = self
        locationService.startUpdatingHeading()
        locationService.startUpdatingLocation()
    }

    private func addSubviews() {
        contentView.addSubview(stackView)
        contentView.addSubview(arrowView)
        contentView.addSubview(mapButton)
    }

    private func setupLayout() {
        var layoutConstraints = [NSLayoutConstraint]()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]

        arrowView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            arrowView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]

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

extension QFCompassViewController: QFCompassViewInput { }

extension QFCompassViewController: LocationServiceDelegate {

    func tracingLocation(currentLocation: CLLocation) { }

    func tracingLocationDidFailWithError(error: NSError) { }

    func tracingHeading(heading: CLHeading) {
        guard let direction = interactor?.getDirectionOfKabah(heading: heading) else { return }
        arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(direction));
    }
}

extension QFCompassViewController {

    @objc private func showMap() {
        router?.showQFMap()
    }
}
