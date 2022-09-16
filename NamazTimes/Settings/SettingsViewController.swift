//
//  SettingsViewController.swift
//  Namaz Times
//
//  Created by &&TairoV on 24.08.2022.
//

import UIKit

protocol SettingsViewInput: GeneralViewControllerProtocol {
    func reload()
    func routeToLanuageSettings(delegate: LanguageSelectionDelegate?)
    func routeToLocationSettings()
}

class SettingsViewtroller: GeneralViewController {

    var router: SettingsRouterInput?
    var interactor: SettingsInteractorInput?
    private let settingsCellId = "settingsReuseId"

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 62, bottom: 0, right: 0)
        tableView.backgroundColor = GeneralColor.backgroundGray
        tableView.register(BaseContainerCell<SettingsItemView>.self, forCellReuseIdentifier: settingsCellId)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureSubviews()

        interactor?.createElements()
    }

    private func configureSubviews() {
        contentView.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
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
}
