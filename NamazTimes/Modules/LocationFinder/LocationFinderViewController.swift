//
//  LocationViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/23/22.
//

import UIKit

protocol LocationFinderViewInput where Self: UIViewController {
    func reload()
    func close()
    func routeToHome()
    func showAlert(with model: GeneralAlertModel)
    func spinnerState(animate: Bool)
    func cellSpinnerState(at indexPath: IndexPath, animate: Bool)
}

class LocationFinderViewController: UIViewController {
    
    var interactor: LocationFinderInteractorInput? {
        didSet {
            closeButton.isHidden = interactor?.hideCloseButton ?? true
        }
    }
    var router: LocationFinderRouterInput?
    
    let resultCellId = "resultCellId"
    let fieldImageView = UIImageView(frame: CGRect(x: 10, y: -10, width: 20, height: 20))
    
    private lazy var fieldLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: locationTextField.frame.height))
    
    private lazy var fieldActionButton: LoadingButton = {
        let button = LoadingButton()
        button.isUserInteractionEnabled = false
        button.setContentInsets(UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.register(BaseContainerCell<LoadingLabelView>.self, forCellReuseIdentifier: resultCellId)
        return  tableView
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
        label.text = "choose_location".localized
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var locationTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.font = UIFont.systemFont(dynamicSize: 16)
        textField.layer.cornerRadius = 18
        textField.returnKeyType =  .done
        textField.autocorrectionType = .no
        return textField
    }()
    
    private var locationButton: LoadingButton = {
        let button = LoadingButton()
        button.setImage(UIImage(named: "location"), for: .normal)
        return button
    }()
    
    private var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close_icon"), for: .normal)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        locationTextField.becomeFirstResponder()
        
        addSubviews()
        setupLayout()
        addActions()
        stylize()
        
        guard let interactor = interactor else { return }
        interactor.checkNetworkConnection()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addSubviews() {
        fieldLeftView.addSubview(fieldImageView)
        view.addSubview(mainStackView)
        view.addSubview(tableView)
        view.addSubview(closeButton)
    }
    
    private func setupLayout() {
        var layoutContraints = [NSLayoutConstraint]()
        
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
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ]
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        layoutContraints += [
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ]
    
    NSLayoutConstraint.activate(layoutContraints)
}

private func addActions() {
    fieldActionButton.addTarget(self, action: #selector(fieldButtonTapped), for: .touchUpInside)
    locationButton.addTarget(self, action: #selector(autoFindLocation), for: .touchUpInside)
    locationTextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: .editingChanged)
    closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
}

private func stylize() {
    
    let bar = UIToolbar()
    bar.sizeToFit()
    bar.items = [ UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                  UIBarButtonItem(title: "done".localized, style: .plain, target: self, action: #selector(doneTapped))]
    
    fieldImageView.contentMode = .scaleAspectFit
    fieldImageView.image = UIImage(named: "search")
    
    locationTextField.leftView = fieldLeftView
    locationTextField.leftViewMode = .always
    
    locationTextField.rightView = fieldActionButton
    locationTextField.rightViewMode = .always
    
    locationTextField.layer.borderWidth = 1
    locationTextField.layer.borderColor = GeneralColor.primary.cgColor
    locationTextField.placeholder = "city_name".localized
    locationTextField.inputAccessoryView = bar
}

@objc private func doneTapped() {
    view.endEditing(true)
}

@objc private func fieldButtonTapped() {
    fieldActionButton.clearMode(isOn: false)
    locationTextField.text?.removeAll()
    interactor?.searchCity(name: "")
}
}

extension LocationFinderViewController: LocationFinderViewInput {
    
    func showAlert(with model: GeneralAlertModel) {
        router?.showAlert(with: model)
    }
    
    func routeToHome() {
        router?.routeToHome()
    }
    
    func spinnerState(animate: Bool) {
        locationButton.spinnerState(animate: animate)
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    func cellSpinnerState(at indexPath: IndexPath, animate: Bool) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BaseContainerCell<LoadingLabelView> else { return }
        cell.innerView.spinnerState(animate: animate)
        tableView.isUserInteractionEnabled = !animate
    }
    
    @objc func close() {
        router?.close()
    }
}

extension LocationFinderViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        fieldActionButton.clearMode(isOn: (string.count == 0 && range.length == 1 && (textField.text?.count ?? 0) > 1))
        
        return true
    }
    
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
        guard let cell: BaseContainerCell<LoadingLabelView> = tableView.dequeueReusableCell(withIdentifier: resultCellId, for: indexPath) as? BaseContainerCell<LoadingLabelView> else {
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
