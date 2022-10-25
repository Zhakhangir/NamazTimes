//
//  GeneralNavigationView.swift
//  NamazTimes
//
//  Created by &&TairoV on 5/16/22.
//

import UIKit
import Lottie

enum NavigationButton: Int {
    case location = 1, settings
}

protocol NavigationButtonDelegate {
    func didTapButton(type: NavigationButton)
}

class GeneralNavigationView: UIView {

    let titleLabel = UILabel()
    let rightButton = UIButton()
    let leftButton = UIButton()
    let seperatorView = UIView()
    var delegate: NavigationButtonDelegate?

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftButton ,titleLabel, rightButton])
        stackView.axis = .horizontal
        stackView.setCustomSpacing(8, after: rightButton)

        return stackView
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
            leftButton.heightAnchor.constraint(equalToConstant: 32),
            leftButton.widthAnchor.constraint(equalToConstant: 32)
        ]

        stackView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)

        ]

        rightButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            rightButton.heightAnchor.constraint(equalToConstant: 32),
            rightButton.widthAnchor.constraint(equalToConstant: 32)
        ]
        
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            seperatorView.heightAnchor.constraint(equalToConstant: 1),
            seperatorView.topAnchor.constraint(equalTo: bottomAnchor),
            seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        backgroundColor = GeneralColor.backgroundGray

        titleLabel.text = GeneralStorageController.shared.getCityInfo()?.cityName
        titleLabel.textColor = GeneralColor.black
        titleLabel.font = UIFont.systemFont(dynamicSize: 20, weight: .medium)
        titleLabel.textAlignment = .left
        
        leftButton.setImage(UIImage(named: "location_point"), for: .normal)
        leftButton.tag = 1
        rightButton.setImage(UIImage(named: "settings"), for: .normal)
        rightButton.tag = 2
        
        seperatorView.backgroundColor = .black.withAlphaComponent(0.2)
        
        leftButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapButton(_ sender: UIButton?) {
        guard let sender = sender else { return }
        
        delegate?.didTapButton(type: NavigationButton(rawValue: sender.tag) ?? .location)
    }
}
