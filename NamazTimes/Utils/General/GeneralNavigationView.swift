//
//  GeneralNavigationView.swift
//  NamazTimes
//
//  Created by &&TairoV on 5/16/22.
//

import UIKit
import Lottie
import CoreLocation

class GeneralNavigationView: UIView {

    let titleLabel = UILabel()
    let miladMonthName = UILabel()
    let hijriMonthName = UILabel()

    private lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: "loader2")
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()

        return animationView
    }()

    private let spaceView = UIView()

    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, monthsStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill

        return stackView
    }()

    lazy var monthsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [miladMonthName, spaceView, hijriMonthName])
        stackView.axis = .horizontal
        stackView.spacing = 8

        return stackView
    }()

    let seperatorView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 1)))
        view.backgroundColor = GeneralColor.black.withAlphaComponent(0.2)

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureHeaderView()
        setupHeaderViewLayout()
        stylizeHeaderView()

        LocationService.sharedInstance.delegate = self
        LocationService.sharedInstance.startUpdatingLocation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHeaderView() {
        addSubview(animationView)
        addSubview(infoStackView)
        addSubview(seperatorView)
    }

    private func setupHeaderViewLayout() {

        var layoutConstraints = [NSLayoutConstraint]()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 70),
            animationView.widthAnchor.constraint(equalToConstant: 70)
        ]

        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            infoStackView.leadingAnchor.constraint(equalTo: animationView.trailingAnchor, constant: 8),
            infoStackView.topAnchor.constraint(equalTo: animationView.topAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

        ]

        spaceView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            spaceView.widthAnchor.constraint(equalToConstant: 2)
        ]

        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            seperatorView.heightAnchor.constraint(equalToConstant: 1),
            seperatorView.topAnchor.constraint(equalTo: bottomAnchor),
            seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]

        if #available(iOS 11.0, *) {
            animationView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        } else {
            animationView.topAnchor.constraint(equalTo: topAnchor, constant: 35).isActive = true
        }

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylizeHeaderView() {
        backgroundColor = GeneralColor.backgroundGray

        titleLabel.textColor = GeneralColor.black
        titleLabel.font = .systemFont(ofSize: 28, weight: .regular)

        miladMonthName.text = "19 ИЮНЬ, 2019"
        miladMonthName.font = .systemFont(ofSize: 15, weight: .medium)
        miladMonthName.minimumScaleFactor = 13
        miladMonthName.textColor = GeneralColor.el_subtitle
        miladMonthName.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        hijriMonthName.text = "16 ШАУУАЛ, 1440"
        hijriMonthName.font = .systemFont(ofSize: 15, weight: .medium)
        hijriMonthName.minimumScaleFactor = 13
        hijriMonthName.textColor = GeneralColor.el_subtitle
        hijriMonthName.setContentHuggingPriority(.defaultLow, for: .horizontal)

        spaceView.backgroundColor = GeneralColor.el_subtitle
        spaceView.layer.cornerRadius = 1
    }
}

extension GeneralNavigationView: LocationServiceDelegate {

    func tracingLocation(currentLocation: CLLocation) {
        LoadingLayer.shared.show()
        currentLocation.fetchCityAndCountry { [weak self] city, region, country, error  in
            self?.titleLabel.text = city ?? region ?? country ?? "-"
            LoadingLayer.shared.hide()
        }
    }

    func tracingLocationDidFailWithError(error: NSError) { }

    func tracingHeading(heading: CLHeading) { }
}
