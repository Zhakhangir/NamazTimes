//
//  SearchResultView.swift
//  Namaz Times
//
//  Created by &&TairoV on 02.08.2022.
//

import UIKit

class LoadingLabelView: UIView {

    private let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(dynamicSize: 16, weight: .regular)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(spinner)
        addSubview(titleLabel)

        var layoutConstrints = [NSLayoutConstraint]()

        spinner.translatesAutoresizingMaskIntoConstraints = false
        layoutConstrints += [
            spinner.heightAnchor.constraint(equalToConstant: 16),
            spinner.widthAnchor.constraint(equalToConstant: 16),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ]

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutConstrints += [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: spinner.leadingAnchor)
        ]
        NSLayoutConstraint.activate(layoutConstrints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func spinnerState(animate: Bool) {
        animate ? spinner.startAnimating() : spinner.stopAnimating()
    }

}

extension LoadingLabelView: CleanableView {
    func clean() { }

    var contentInset: UIEdgeInsets { UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0) }
}
