//
//  HomeViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit

protocol HomeViewInput: GeneralViewControllerProtocol { }

class HomeViewController: GeneralViewController {

    var interactor: HomeInteractorInput?
    var router: HomeRouterInput?

    private let prayerTimeInfo = 3
    private let parayerCellReuseId = "PrayerTimeCell"
    private let currentTime = UILabel()
    private let currentTimeStatus = UILabel()

    private lazy var currentTimeStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [currentTimeStatus, currentTime])
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = nil
        tableView.tableHeaderView = nil
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false

        tableView.register(BaseContainerCell<CurrentPrayerTimeView>.self, forCellReuseIdentifier: parayerCellReuseId)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addSubviews()
        setupLayout()
        stylize()

        tableView.reloadData()
    }

    private func addSubviews() {
        contentView.addSubview(tableView)
        contentView.addSubview(currentTimeStack)
    }

    private func setupLayout() {
        var layoutConstraints = [NSLayoutConstraint]()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 64),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -64)
        ]

        currentTimeStack.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            currentTimeStack.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 100),
            currentTimeStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            currentTimeStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            currentTimeStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        currentTime.textAlignment = .center
        currentTime.numberOfLines = 0
        currentTime.font = .systemFont(ofSize: 32)
    }

    override func secondRefresh() {
        currentTime.text = Date().timeString(withFormat: .full)
    }
}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayerTimeInfo
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: BaseContainerCell<CurrentPrayerTimeView> = tableView.dequeueReusableCell(withIdentifier: parayerCellReuseId, for: indexPath) as? BaseContainerCell<CurrentPrayerTimeView> else {
            return UITableViewCell()
        }
        cell.innerView.label.text = "Current Prayer Name"
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {

}

extension HomeViewController: HomeViewInput {}
