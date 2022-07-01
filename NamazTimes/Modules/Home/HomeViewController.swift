//
//  HomeViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit

class HomeViewController: GeneralViewController {

    var interactor: HomeInteratorInput?
    var router: HomeRouterInput?

    private let prayerTimeInfo = 3
    private let parayerCellReuseId = "PrayerTimeCell"
    private let currentTime = UILabel()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
        tableView.separatorInset = UIEdgeInsets.zero

        tableView.register(BaseContainerCell<PrayerTimeInfoView>.self, forCellReuseIdentifier: parayerCellReuseId)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addSubviews()
        setupLayout()
        stylize()
    }

    private func addSubviews() {
        contentView.addSubview(tableView)
        contentView.addSubview(currentTime)
    }

    private func setupLayout() {
        var layoutConstraints = [NSLayoutConstraint]()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 64),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -64)
        ]

        currentTime.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        currentTime.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            currentTime.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            currentTime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        currentTime.textAlignment = .center
        currentTime.numberOfLines = 0
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
        guard let cell: BaseContainerCell<PrayerTimeInfoView> = tableView.dequeueReusableCell(withIdentifier: parayerCellReuseId, for: indexPath) as? BaseContainerCell<PrayerTimeInfoView> else {
            return UITableViewCell()
        }

        return cell
    }
}

extension HomeViewController: UITableViewDelegate {

}

extension HomeViewController: HomeViewInput {}
