//
//  File.swift
//  Namaz Times
//
//  Created by &&TairoV on 03.09.2022.
//

import UIKit

class LanguageSelectItemView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()

    let icon = UIImageView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [icon, titleLabel])
        stackView.spacing = 8
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureSubview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubview() {
        addSubview(stackView)

        var layoutConstraints = [NSLayoutConstraint]()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ]

        icon.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            icon.heightAnchor.constraint(equalToConstant: 18),
            icon.widthAnchor.constraint(equalToConstant: 24)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }
}

extension LanguageSelectItemView: CleanableView {
    var contentInset: UIEdgeInsets { .zero }

    func clean() { }
}
