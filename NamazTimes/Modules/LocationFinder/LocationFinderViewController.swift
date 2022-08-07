//
//  LocationViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/23/22.
//

import UIKit
import Lottie

protocol LocationFinderViewInput: GeneralViewControllerProtocol {
    func reload()
    func fieldSpinner(animate: Bool)
    func routeToHome()
    func showAlert()
}

class LocationFinderViewController: GeneralViewController {

    var interactor: LocationFinderInteractorInput?
    var router: LocationFinderRouterInput?

    let resultCellId = "resultCellId"
    let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    let fieldImageView = UIImageView(frame: CGRect(x: 10, y: -10, width: 20, height: 20))

    private lazy var tableBottomConstraint = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    private lazy var tableBottomSafeConstraint = NSLayoutConstraint()

    private let fieldRightView = UIView()
    private lazy var fieldLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: locationTextField.frame.height))

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.register(BaseContainerCell<SimpleLabelView>.self, forCellReuseIdentifier: resultCellId)
        return  tableView
    }()

    private let animationView: AnimationView = {
        let animationView = AnimationView(name: "search_animation_1")
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.clipsToBounds = true
        animationView.loopMode = .loop
        animationView.animationSpeed = 2.5
        return animationView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, fieldStackView])
        stackView.alignment = .fill
        stackView.spacing = 32
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

    private lazy var locationTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
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
        registerKeyboardNotifications()

        addSubviews()
        setupLayout()
        addActions()
        stylize()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    private func addSubviews() {
        fieldLeftView.addSubview(fieldImageView)
        fieldRightView.addSubview(spinner)
        view.addSubview(mainStackView)
        view.addSubview(tableView)

    }

    private func setupLayout() {
        var layoutContraints = [NSLayoutConstraint]()

        spinner.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            spinner.topAnchor.constraint(equalTo: fieldRightView.topAnchor),
            spinner.leadingAnchor.constraint(equalTo: fieldRightView.leadingAnchor),
            spinner.bottomAnchor.constraint(equalTo: fieldRightView.bottomAnchor),
            spinner.trailingAnchor.constraint(equalTo: fieldRightView.trailingAnchor, constant: -8),
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
            tableView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ]

        if #available(iOS 11.0, *) {
            tableBottomSafeConstraint = tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            layoutContraints += [
                mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
                tableBottomSafeConstraint
            ]
        } else {
            tableBottomSafeConstraint = tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -16)
            layoutContraints += [
                mainStackView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor, constant: 32),
                tableBottomSafeConstraint
            ]
        }

        NSLayoutConstraint.activate(layoutContraints)
    }

    private func addActions() {
        locationButton.addTarget(self, action: #selector(autoFindLocation), for: .touchUpInside)
        locationTextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: .editingChanged)
    }

    private func stylize() {

        let bar = UIToolbar()
        bar.sizeToFit()
        bar.items = [ UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                      UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))]

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
    }
}

extension LocationFinderViewController: LocationFinderViewInput {

    func showAlert() {}

    func routeToHome() {
        router?.routeToHome()
    }

    func fieldSpinner(animate: Bool) {
        if animate {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }

    func reload() {
        tableView.reloadData()
    }
}

extension LocationFinderViewController: UITextFieldDelegate {

    @objc private func textFieldEditingDidChange(_ sender: UITextField) {
        interactor?.searchCity(name: sender.text)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension LocationFinderViewController {

    @objc func autoFindLocation() { }
}

extension  LocationFinderViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor?.getNumberOfSection() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  interactor?.getNumberOfRows(in: section) ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        interactor?.getTitle(for: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: BaseContainerCell<SimpleLabelView> = tableView.dequeueReusableCell(withIdentifier: resultCellId, for: indexPath) as? BaseContainerCell<SimpleLabelView> else {
            return UITableViewCell()
        }

        guard let item = interactor?.getItem(at: indexPath) else { return UITableViewCell() }
        cell.innerView.titleLabel.text = item.text
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        interactor?.didSelectItem(at: indexPath)
    }
}

extension LocationFinderViewController {
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            tableBottomConstraint.constant = -(keyboardRectangle.height)
            tableBottomConstraint.isActive = true
            tableBottomSafeConstraint.isActive = false
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        tableBottomConstraint.isActive = false
        tableBottomSafeConstraint.isActive = true
    }
}
