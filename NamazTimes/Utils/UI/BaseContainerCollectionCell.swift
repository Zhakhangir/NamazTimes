//
//  BaseContainerCollectionCell.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import UIKit

final class BaseCollectionContainerCell<T: CleanableView>: UICollectionViewCell {

    let innerView = T()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func prepareForReuse() {
        super.prepareForReuse()
        innerView.clean()
    }

    private func addSubviews() {
        backgroundColor = innerView.containerBackgroundColor
        contentView.addSubview(innerView)

        var layoutConstraints = [NSLayoutConstraint]()

        innerView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            innerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: innerView.contentInset.top),
            innerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: innerView.contentInset.left),
            innerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: innerView.contentInset.bottom),
            innerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: innerView.contentInset.right)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }
}


