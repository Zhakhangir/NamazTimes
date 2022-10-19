//
//  QiblaArrowView.swift
//  Namaz Times
//
//  Created by &&TairoV on 28.07.2022.
//

import UIKit

class QFArrowView: UIView {

    private let arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "qibla_arrow")

        return imageView
    }()

    private let arrowTitleView = UIView()

    let arrowTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: 22, weight: .semibold)
        label.alpha = 0.8
        label.transform = CGAffineTransform(rotationAngle: 3*CGFloat.pi/2)
        label.text = "qibla".localized
        label.textColor = .white
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        arrowTitleView.addSubview(arrowTitle)
        addSubview(arrowImage)
        addSubview(arrowTitleView)
    }

    private func setupLayout() {
        var layoutConstraints = [NSLayoutConstraint]()

        arrowTitle.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            arrowTitle.topAnchor.constraint(equalTo: arrowTitleView.topAnchor),
            arrowTitle.leadingAnchor.constraint(equalTo: arrowTitleView.leadingAnchor),
            arrowTitle.bottomAnchor.constraint(equalTo: arrowTitleView.bottomAnchor),
            arrowTitle.trailingAnchor.constraint(equalTo: arrowTitleView.trailingAnchor)
        ]

        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            arrowImage.topAnchor.constraint(equalTo: topAnchor),
            arrowImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            arrowImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]

        arrowTitleView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            arrowTitleView.centerYAnchor.constraint(equalTo: arrowImage.centerYAnchor),
            arrowTitleView.centerXAnchor.constraint(equalTo: arrowImage.centerXAnchor)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }
}
