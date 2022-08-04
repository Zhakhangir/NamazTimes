//
//  SearchResultView.swift
//  Namaz Times
//
//  Created by &&TairoV on 02.08.2022.
//

import UIKit

class SimpleLabelView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SimpleLabelView: CleanableView {
    func clean() { }

    var contentInset: UIEdgeInsets { UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8) }
}
