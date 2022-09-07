//
//  SettingsItemView.swift
//  Namaz Times
//
//  Created by &&TairoV on 02.09.2022.
//
import UIKit

class SettingsItemView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(dynamicSize: 16, weight: .regular)
        label.textColor = GeneralColor.el_subtitle
        return label
    }()

    let iconImageView = UIImageView()

    let accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chevron_right")
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.spacing = 8
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(iconImageView)
        addSubview(stackView)
        addSubview(accessoryImageView)

        var layoutConstraints = [NSLayoutConstraint]()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            stackView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: accessoryImageView.leadingAnchor, constant: -8),
        ]

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30)
        ]

        accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            accessoryImageView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            accessoryImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 20),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 20)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func setupLayout() {

    }
}

extension SettingsItemView: CleanableView {
    var contentInset: UIEdgeInsets { .zero }

    func clean() { }
}



