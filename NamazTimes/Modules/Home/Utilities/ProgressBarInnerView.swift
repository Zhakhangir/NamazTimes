//
//  ProgressBarInnerView.swift
//  Namaz Times
//
//  Created by &&TairoV on 29.08.2022.
//

import UIKit

class ProgressBarInnerView: UIView {

    private let topSeparator: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 0.7)
        layer.backgroundColor = GeneralColor.darkGray.cgColor.copy(alpha: 0.5)
        return layer
    }()
    private let bottomSeparator: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 0.7)
        layer.backgroundColor = GeneralColor.darkGray.cgColor.copy(alpha: 0.5)
        return layer
    }()

    private lazy var topSpace: UIView = {
        let view = UIView()
        view.layer.addSublayer(topSeparator)
        return view
    }()

    private lazy var bottomSpace: UIView = {
        let view = UIView()
        view.layer.addSublayer(bottomSeparator)
        return view
    }()

    lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: 36, weight: .medium)
        label.textAlignment = .center
        label.textColor = GeneralColor.primary
        return label
    }()

    lazy var remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: 24, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    lazy var nextTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: 24, weight: .light)
        label.textAlignment = .center
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            currentTimeLabel,
            topSpace,
            remainingTimeLabel,
            bottomSpace,
            nextTimeLabel
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        addSubview(stackView)

        var layoutConstraints = [NSLayoutConstraint]()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]


        topSpace.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            topSpace.heightAnchor.constraint(equalToConstant: 15)
        ]

        bottomSpace.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            bottomSpace.heightAnchor.constraint(equalToConstant: 15)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    func setTimaValues(currentTime: String, nextTime: String) {
        currentTimeLabel.text = currentTime
        nextTimeLabel.text = nextTime
    }

    func updateReminingTime(interval: TimeInterval, nextTime: String) {

        let time = NSInteger(interval)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)

        let attrString = NSMutableAttributedString()
        let nextTime = NSAttributedString(string: nextTime + " " + "vaktine kalan")
        let reminigTime = NSAttributedString(string: "\n\(minutes) dakika \(seconds) saniye", attributes: [ .font: UIFont.monospacedDigitSystemFont(dynamicSize: 22, weight: .medium) ])
        attrString.append(nextTime)
        attrString.append(reminigTime)
        remainingTimeLabel.attributedText = attrString

    }

    let separatorLine = CALayer()

    override func layoutSubviews() {
        topSeparator.position = CGPoint(x: topSpace.bounds.midX, y: topSpace.bounds.midY)
        bottomSeparator.position = CGPoint(x: topSpace.bounds.midX, y: topSpace.bounds.midY)
    }
}
