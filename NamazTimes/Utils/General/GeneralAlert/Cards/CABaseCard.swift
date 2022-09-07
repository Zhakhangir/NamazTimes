//
//  GeneralAlertCard.swift
//  NamazTimes
//
//  Created by &&TairoV on 5/1/22.
//

import UIKit

struct GeneralAlertModel {
    let titleLabel: String
    var descriptionLabel: String? = nil
    let buttonTitle: String
    var actionButtonTapped: (() -> Void)?
    var withCancel: Bool = false
}

final class GeneralAlertPopupView: UIView, AlertPopupView {

    var dismissVcButtonTapped: (() -> Void)?
    private var actionButtonTapped: (() -> Void)?

    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let closeButton = UIButton()
    private let actionButton = UIButton()
    private let cancelButton = UIButton()

    private lazy var messageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 16

        return stackView
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cancelButton, actionButton])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 16

        return stackView
    }()

    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [messageStackView, buttonStackView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 48  
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setupLayout()
        stylize()
        addActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: GeneralAlertModel) {
        titleLabel.text = model.titleLabel
        subTitleLabel.text = model.descriptionLabel
        actionButton.setTitle(model.buttonTitle, for: .normal)
        actionButtonTapped = model.actionButtonTapped
        cancelButton.isHidden = !model.withCancel
    }

    private func addSubviews() {
        addSubview(closeButton)
        addSubview(contentStack)
    }

    private func setupLayout() {
        var layoutConstraints = [NSLayoutConstraint]()

//        translatesAutoresizingMaskIntoConstraints = false
//        layoutConstraints += [
//            heightAnchor.constraint(equalToConstant: 250),
//            widthAnchor.constraint(equalToConstant: 250)
//        ]

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40)
        ]

        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            buttonStackView.heightAnchor.constraint(equalToConstant: 48)
        ]

        contentStack.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            contentStack.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 4),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        backgroundColor = .white

        titleLabel.font = .systemFont(dynamicSize: 18, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .black

        subTitleLabel.font = .systemFont(dynamicSize: 16, weight: .regular)
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textColor = GeneralColor.el_subtitle

        closeButton.setImage(UIImage(named: "close_icon_red"), for: .normal)

        actionButton.backgroundColor = GeneralColor.primary
        actionButton.titleLabel?.textColor = .white
        actionButton.layer.cornerRadius = 12

        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .red
        cancelButton.layer.cornerRadius = 12
    }

    @objc private func hundleActionButton() {
        actionButtonTapped?()
        dismissVcButtonTapped?()
    }

    @objc private func hundleCloseButton() {
        dismissVcButtonTapped?()
    }

    private func addActions() {
        closeButton.addTarget(self, action: #selector(hundleCloseButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(hundleCloseButton), for: .touchUpInside)
        actionButton.addTarget(self, action: #selector(hundleActionButton), for: .touchUpInside)
    }
}


