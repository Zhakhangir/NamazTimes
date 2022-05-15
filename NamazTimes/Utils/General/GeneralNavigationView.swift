//
//  GeneralNavigationView.swift
//  NamazTimes
//
//  Created by &&TairoV on 5/16/22.
//

import UIKit
import Lottie

class GeneralNavigationView: UIView {

    let titleLabel = UILabel()
    let miladMonthName = UILabel()
    let hijriMonthName = UILabel()

    private lazy var locationAnimationView: AnimationView = {
        let animationView = AnimationView(name: "loader2")
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()

        return animationView
    }()

    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationAnimationView, messageStackView])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center

        return stackView
    }()

    lazy var messageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, monthsStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill

        return stackView
    }()

    lazy var monthsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [miladMonthName, hijriMonthName])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center

        return stackView
    }()

    let seperatorView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 1)))
        view.backgroundColor = GeneralColor.black.withAlphaComponent(0.5)

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureHeaderView()
        setupHeaderViewLayout()
        stylizeHeaderView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHeaderView() {
        addSubview(headerStackView)
        addSubview(seperatorView)
    }

    private func setupHeaderViewLayout() {

        var layoutConstraints = [NSLayoutConstraint]()

        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            headerStackView.topAnchor.constraint(equalTo: topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor)

        ]

        locationAnimationView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            locationAnimationView.heightAnchor.constraint(equalToConstant: 100),
            locationAnimationView.widthAnchor.constraint(equalToConstant: 100)
        ]

        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            seperatorView.heightAnchor.constraint(equalToConstant: 1),
            seperatorView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor),
            seperatorView.leadingAnchor.constraint(equalTo: headerStackView.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: headerStackView.trailingAnchor)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylizeHeaderView() {
        titleLabel.text = "Алматы"
        titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        miladMonthName.textColor = GeneralColor.black

        miladMonthName.text = "19 ИЮНЬ, 2019"
        miladMonthName.font = .systemFont(ofSize: 13, weight: .regular)
        miladMonthName.textColor = GeneralColor.el_subtitle

        hijriMonthName.text = "16 ШАУУАЛ, 1440"
        hijriMonthName.font = .systemFont(ofSize: 13, weight: .regular)
        hijriMonthName.textColor = GeneralColor.el_subtitle
    }
}
