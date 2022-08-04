//
//  LocationViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/23/22.
//

import UIKit
import Lottie

class LocationSettingsViewController: UIViewController {

    let locationService = LocationService.sharedInstance
    let fieldImageView = UIImageView(frame: CGRect(x: 10, y: -10, width: 20, height: 20))
    let resultCellId = "resultCellId"
    private let networkManager = NetworkManager()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(BaseContainerCell<SimpleLabelView>.self, forCellReuseIdentifier: resultCellId)
        return  tableView
    }()

    private let animationView: AnimationView = {
        let animationView = AnimationView(name: "search_animation_1")
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.loopMode = .loop
        animationView.animationSpeed = 2.5
        return animationView
    }()

    private let fieldRightView = UIView()

    lazy var fieldLeftView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: locationTextField.frame.height))
        view.addSubview(fieldImageView)
        return  view
    }()

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

    private var locationTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .webSearch
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.cornerRadius = 18
        textField.returnKeyType = .go
        textField.autocorrectionType = .no
        return textField
    }()

    private var locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "location"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        locationTextField.delegate = self

        addSubviews()
        setupLayout()
        addActions()
        stylize()
    }

    private func addSubviews() {
        fieldRightView.addSubview(animationView)
        view.addSubview(mainStackView)
        view.addSubview(tableView)

    }

    private func setupLayout() {
        var layoutContraints = [NSLayoutConstraint]()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            animationView.heightAnchor.constraint(equalToConstant: 24),
            animationView.widthAnchor.constraint(equalToConstant: 24),
            animationView.topAnchor.constraint(equalTo: fieldRightView.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: fieldRightView.leadingAnchor),
            animationView.bottomAnchor.constraint(equalTo: fieldRightView.bottomAnchor),
            animationView.trailingAnchor.constraint(equalTo: fieldRightView.trailingAnchor, constant: -5),
        ]

        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            locationTextField.heightAnchor.constraint(equalToConstant: 42)
        ]

        locationButton.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            locationButton.heightAnchor.constraint(equalToConstant: 24),
            locationButton.widthAnchor.constraint(equalToConstant: 24)
        ]

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ]

        tableView.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            tableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -(24 + 5))
        ]

        if #available(iOS 11.0, *) {
            layoutContraints += [
                mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            ]
        } else {
           layoutContraints += [
            mainStackView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor, constant: 32),
            tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -16)]
        }

        NSLayoutConstraint.activate(layoutContraints)
    }

    private func addActions() {
        locationButton.addTarget(self, action: #selector(autoFindLocation), for: .touchUpInside)
    }

    private func stylize() {

        let bar = UIToolbar()
        bar.sizeToFit()
        bar.items = [ UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                      UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(doneTapped))]

        fieldImageView.contentMode = .scaleAspectFit
        fieldImageView.image = UIImage(named: "search")

        locationTextField.leftView = fieldLeftView
        locationTextField.leftViewMode = .always

        locationTextField.rightView = fieldRightView
        locationTextField.rightViewMode = .always

        locationTextField.layer.borderWidth = 1
        locationTextField.layer.borderColor = GeneralColor.primary.cgColor
        locationTextField.placeholder = NSLocalizedString("city_name", comment: "city name")
        locationTextField.inputAccessoryView = bar
    }

    @objc private func doneTapped() {
        view.endEditing(true)
        
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.animationView.stop()
        }
    }
}

extension LocationSettingsViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        networkManager.searchCity(cityName: textField.text ?? "") { error in

        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        autoFindLocation()
        return true
    }
}

extension LocationSettingsViewController {

    @objc func autoFindLocation() {
    }
}

extension  LocationSettingsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
