//
//  HeaderCloseView.swift
//  Namaz Times
//
//  Created by &&TairoV on 06.09.2022.
//

import UIKit

class BaseHeaderView: UIView {

    var closeAction: (()->Void)?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = BaseFont.medium.withSize(16)
        label.textColor = .black
        return label
    }()

    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close_icon"), for: .normal)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, closeButton])
        stackView.spacing = 4
        stackView.axis = .horizontal
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = GeneralColor.backgroundGray
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
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
            stackView.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    @objc private func closeTapped() {
        closeAction?()
    }
}
