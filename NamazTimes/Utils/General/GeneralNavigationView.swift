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
    let rightButton = UIButton()
    let leftButton = UIButton()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftButton ,titleLabel, rightButton])
        stackView.axis = .vertical
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

        configureSubviews()
        stylize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {

        addSubview(stackView)
        addSubview(seperatorView)
        
        var layoutConstraints = [NSLayoutConstraint]()
            
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            leftButton.heightAnchor.constraint(equalToConstant: 30),
            leftButton.widthAnchor.constraint(equalToConstant: 30)
        ]

        stackView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)

        ]

        rightButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            rightButton.heightAnchor.constraint(equalToConstant: 30),
            rightButton.widthAnchor.constraint(equalToConstant: 30)
        ]
        
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            seperatorView.topAnchor.constraint(equalTo: bottomAnchor),
            seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        backgroundColor = GeneralColor.backgroundGray

        titleLabel.textColor = GeneralColor.black
        titleLabel.font = BaseFont.regular.withSize(25)
        titleLabel.textAlignment = .left
    }
}
