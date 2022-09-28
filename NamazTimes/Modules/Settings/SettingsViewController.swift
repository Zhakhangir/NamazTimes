//
//  SettingsViewController.swift
//  Namaz Times
//
//  Created by &&TairoV on 24.08.2022.
//

import UIKit

protocol SettingsViewInput where Self: UIViewController {
    func reload()
    func routeToLanuageSettings(delegate: LanguageSelectionDelegate?)
    func routeToLocationSettings()
    func routeToParent()
}

class SettingsViewtroller: UIViewController {

    var router: SettingsRouterInput?
    var interactor: SettingsInteractorInput?
    private let settingsCellId = "settingsReuseId"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "app_settings".localized
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        button.setImage(UIImage(named: "close_icon"), for: .normal)
        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 62, bottom: 0, right: 0)
        tableView.backgroundColor = .clear
        tableView.register(BaseContainerCell<SettingsItemView>.self, forCellReuseIdentifier: settingsCellId)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = GeneralColor.backgroundGray
        configureSubviews()

        interactor?.createElements()
    }

    private func configureSubviews() {
        var layoutConstraints = [NSLayoutConstraint]()
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(closeButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
}

extension SettingsViewtroller: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = BaseSectionHeadFooterView()
        headerView.titleLabel.text = interactor?.getSection(at: section).title

        return headerView
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor?.getSectionCount() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.getNumberOfItems(in: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let item = interactor?.getItem(by: indexPath) else { return UITableViewCell() }
        guard let cell: BaseContainerCell<SettingsItemView> = tableView.dequeueReusableCell(withIdentifier: settingsCellId, for: indexPath) as? BaseContainerCell<SettingsItemView> else { return UITableViewCell() }

        cell.innerView.iconImageView.image = item.icon
        cell.innerView.titleLabel.text = item.title
        cell.innerView.descriptionLabel.text = item.description

        return cell
    }
    
    @objc private func close() {
        self.dismiss(animated: true)
    }
}

extension SettingsViewtroller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectItem(at: indexPath)
    }
}

extension SettingsViewtroller: SettingsViewInput {
   
    func reload() {tableView.reloadData() }

    func routeToLanuageSettings(delegate: LanguageSelectionDelegate?) {
        router?.routeToLanuageSettings(delegate: delegate)
    }

    func routeToLocationSettings() {
        router?.routeToLocationSettings()
    }
    
    func routeToParent() {
        router?.routeToParent()
    }
}
