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
    var code: String
}

protocol LanguageSelectionDelegate {
    func didSelectLanguage()
}

class LanguageSelectionViewController: UIViewController {

    private let languageCellId = "languageSelectCellId"
    var delegate: LanguageSelectionDelegate?
    let headerView = BaseHeaderView()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.text = "choose_location".localized
        label.numberOfLines = 0
        return label
    }()

    var languages: [LanguageSettings] = [
        .init(title: "Қазақ",icon: UIImage(named: "flag_kaz"), code: "kk"),
        .init(title: "Русский", icon: UIImage(named: "flag_rus"), code: "ru")
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

    convenience init(delegate: LanguageSelectionDelegate?) {
        self.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = GeneralColor.backgroundGray

        headerView.titleLabel.text = "choose_language".localized
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
        let selectedLanguage = UserDefaults.standard.string(forKey: "language") ?? ""
        if item.code == selectedLanguage {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        return cell
    }
}

extension LanguageSelectionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(languages[indexPath.row].code, forKey: "language")
        UserDefaults().synchronize()
       
        self.dismiss(animated: true, completion: {
            UIApplication.shared.keyWindow?.rootViewController = GeneralTabBarViewController(selectedIndex: 3)
        })
    }
}
