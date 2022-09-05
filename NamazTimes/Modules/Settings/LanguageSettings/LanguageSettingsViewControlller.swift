//
//  LanguageSettingsViewControlller.swift
//  Namaz Times
//
//  Created by &&TairoV on 04.09.2022.
//

import UIKit

struct LanguageSettings {
    var title: String?
    var icon: UIImage?
    var isSelected: Bool = false
}

class LanguageSelectionViewController: UIViewController {

    private let languageCellId = "languageSelectCellId"

    var languages: [LanguageSettings] = [
        .init(title: "Қазақ", icon: UIImage(named: "flag_kaz"), isSelected: false),
        .init(title: "Русский", icon: UIImage(named: "flag_rus"), isSelected: true)
    ]

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        tableView.tableFooterView = nil
        tableView.register(BaseContainerCell<LanguageSelectItemView>.self, forCellReuseIdentifier: languageCellId)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = GeneralColor.backgroundGray
        configureSubviews()
        tableView.reloadData()
    }

    private func configureSubviews() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

extension LanguageSelectionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = languages[indexPath.row]
        guard let cell: BaseContainerCell<LanguageSelectItemView> = tableView.dequeueReusableCell(withIdentifier: languageCellId, for: indexPath) as? BaseContainerCell<LanguageSelectItemView> else { return UITableViewCell() }

        cell.innerView.titleLabel.text = item.title
        cell.innerView.icon.image = item.icon
        cell.accessoryType = item.isSelected ? .checkmark : .none

        return cell
    }
}

extension LanguageSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for (index, _) in languages.enumerated() {
            languages[index].isSelected = indexPath.row == index
        }
    }
}
