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

    let headerView = BaseHeaderView()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.text = NSLocalizedString("choose_location", comment: "choose location")
        label.numberOfLines = 0
        return label
    }()

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
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 0)
        tableView.tableFooterView = nil
        tableView.register(LanguageCell.self, forCellReuseIdentifier: languageCellId)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = GeneralColor.backgroundGray

        headerView.titleLabel.text = "Выберите язык"
        headerView.closeAction = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        configureSubviews()
        tableView.reloadData()
    }

    private func configureSubviews() {
        view.addSubview(headerView)
        view.addSubview(tableView)

        var layoutConstrints = [NSLayoutConstraint]()

        headerView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstrints += [
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)

        ]

        tableView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstrints += [
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        NSLayoutConstraint.activate(layoutConstrints)
    }

}

extension LanguageSelectionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = languages[indexPath.row]
        guard let cell: LanguageCell = tableView.dequeueReusableCell(withIdentifier: languageCellId, for: indexPath) as? LanguageCell else { return UITableViewCell() }
        cell.configure(viewModel: item)
        if item.isSelected {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
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
