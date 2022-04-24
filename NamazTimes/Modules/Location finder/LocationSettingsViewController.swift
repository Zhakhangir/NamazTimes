//
//  LocationViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/23/22.
//

import UIKit

class LocationFinderViewController: UIViewController {

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, fieldStackView])
        stackView.alignment = .fill
        stackView.spacing = 40
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var fieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationTextField, locationButton])
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.axis = .horizontal
        return stackView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.text = NSLocalizedString("choose_location", comment: "choose location")
        label.numberOfLines = 0
        return label
    }()

    private var locationTextField = UITextField()

    private var locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "location"), for: .normal)
        return button
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

        let iconView = UIImageView()
        iconView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        iconView.contentMode = .scaleAspectFit
        iconView.image = UIImage(named: "search")

        locationTextField.leftView = iconView
        locationTextField.leftViewMode = .always

        view.addSubview(mainStackView)
    }

    private func setupLayout() {

        var layoutContraints = [NSLayoutConstraint]()

        locationTextField.delegate = self
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            locationTextField.heightAnchor.constraint(equalToConstant: 48)
        ]

        locationButton.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            locationButton.heightAnchor.constraint(equalToConstant: 24),
            locationButton.widthAnchor.constraint(equalToConstant: 24)
        ]

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ]

        NSLayoutConstraint.activate(layoutContraints)
    }

    private func addActions() {
        locationButton.addTarget(self, action: #selector(autoFindLocation), for: .touchUpInside)
    }

    private func stylize() {
        locationTextField.keyboardType = .webSearch
        locationTextField.font = UIFont.systemFont(ofSize: 16)
        locationTextField.layer.cornerRadius = 24

        locationTextField.layer.borderWidth = 1
        locationTextField.layer.borderColor = GeneralColor.primary.cgColor
        locationTextField.placeholder = NSLocalizedString("city_name", comment: "city name")

        locationTextField.returnKeyType = .go
        locationTextField.autocorrectionType = .no
    }
}

extension LocationFinderViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension LocationFinderViewController {

    @objc func autoFindLocation() {
        let alert = UIAlertController(title: "Location", message: "Let me find your location", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] alert  in
            self?.navigationController?.pushViewController(TabBar(), animated: true)
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)

        alert.addAction(okAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }
}

