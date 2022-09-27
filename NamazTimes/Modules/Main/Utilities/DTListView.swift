//
//  DailyTimesListCollectionCell.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.05.2022.
//

import UIKit

class DTListView: UIView {

    private var timesList = [DailyPrayerTime]()
    private let cellReuseId  = "DTListCell"
    private var mode: DeviceSize = .big
    private let defaultRowHeight: CGFloat = 48.0

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = defaultRowHeight
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = nil
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.register(DTListItemCell.self, forCellReuseIdentifier: cellReuseId)

        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    convenience init(mode: DeviceSize = .big) {
        self.init(frame: .zero)
        self.mode = mode

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
        reload()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {

        addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func set(data: [DailyPrayerTime]) {
        timesList = data
        reload()
    }

    func set(rowHeight: CGFloat) {
        tableView.rowHeight = rowHeight
        reload()
    }

    func reload() {
        tableView.reloadData()
    }
}

extension DTListView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: DTListItemCell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as? DTListItemCell else {
            return UITableViewCell()
        }

        let item = timesList[indexPath.row]
        cell.configure(viewModel: item, mode: mode)
        if item.selected {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        cell.separatorInset.left = indexPath.row == timesList.count-1 ? tableView.frame.width : 0
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timesList.count
    }
}
