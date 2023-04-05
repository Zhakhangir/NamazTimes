//
//  LocationAccessErrorViewController.swift
//  Namaz Times
//
//  Created by &&TairoV on 28.07.2022.
//

import UIKit

protocol ErrorPageViewInput where Self: UIViewController {
    
}

class ErrorPageViewController: UIViewController {
    
    var router: ErrorPageRouterInput?
    var interactor: ErrorPageInteractorInput?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .red
        label.font = UIFont.systemFont(dynamicSize: 24, weight: .regular)
        return label
    }()

    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font =  UIFont.systemFont(dynamicSize: 16, weight: .regular)
        return textView
    }()

    private let actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = GeneralColor.primary
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
        stylize()
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
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ]

        stackView.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]

        NSLayoutConstraint.activate(layoutContraints)
    }

    private func addActions() {
        actionButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }
    
    private func stylize() {
        guard let type = interactor?.getErrorType() else { return }
        titleLabel.text = type.title
        messageTextView.text = type.message
        actionButton.setTitle(type.actionTitle, for: .normal)
    }

    @objc func buttonTap() {
        interactor?.didTapButton()
    }
    
    
}

extension ErrorPageViewController: ErrorPageViewInput {
    
}
