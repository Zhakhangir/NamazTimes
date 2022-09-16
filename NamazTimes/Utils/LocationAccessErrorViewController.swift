//
//  LocationAccessErrorViewController.swift
//  Namaz Times
//
//  Created by &&TairoV on 28.07.2022.
//

import UIKit

class LocationAccessErrorViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .red
        label.text = "warning".localized + "!"
        label.font = .systemFont(dynamicSize: 25, weight: .regular)
        return label
    }()

    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.text = "location_access".localized
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = .systemFont(dynamicSize: 16, weight: .regular)
        return textView
    }()

    private let actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = GeneralColor.primary
        button.setTitle("open_settings".localized, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, messageTextView])
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        addSubviews()
        setupLayout()
        addActions()
    }

    private func addSubviews() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
    }

    private func setupLayout() {

        var layoutContraints = [NSLayoutConstraint]()

        actionButton.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 48),
        ]

        stackView.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]

        if #available(iOS 11.0, *) {
            layoutContraints += [
                stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            ]
        } else {
            layoutContraints += [
                stackView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor, constant: 16),
                actionButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor, constant: -16)
            ]
        }

        NSLayoutConstraint.activate(layoutContraints)
    }

    private func addActions() {
        actionButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }

    @objc func buttonTap() {
        if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
            UIApplication.shared.open(url)
        }
    }
}
