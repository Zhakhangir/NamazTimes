//
//  DailyTimesListCollectionCell.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.05.2022.
//

import UIKit

class DTListView: UIView {

    private var timesList = [PrayerTimesList]()
    private let cellReuseId  = "DTListCell"
    private let  rowHeight = 48

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = CGFloat(rowHeight)
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = nil
        tableView.tableFooterView = UIView()
        tableView.register(BaseContainerCell<DTListItemView>.self, forCellReuseIdentifier: cellReuseId)

        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        timesList += [
            .init(name: "Имсак", time: "3:02", show: true),
            .init(name: "Бамдат", time: "3:22", show: true),
            .init(name: "Күн", time: "5:24", show: true),
            .init(name: "Ишрак", time: "6:50", show: true),
            .init(name: "Керахат", time: "5:24", show: true),
            .init(name: "Бесін", time: "13:09", show: true),
            .init(name: "Асри аууал", time: "13:09", show: true),
            .init(name: "Екінді", time: "18:22", show: true),
            .init(name: "Исфирар", time: "18:22", show: true),
            .init(name: "Ақшам", time: "20:34", show: true),
            .init(name: "Иштибак", time: "18:22", show: true),
            .init(name: "Құптан", time: "22:36", show: true),
            .init(name: "Ишаи сани", time: "18:22", show: true)
        ]
        
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

    func set(data: [PrayerTimesList]) {
        timesList = data
        reload()
    }

    func set(rowHeight: CGFloat) {
        tableView.rowHeight = rowHeight
        reload()
    }

    func updateTableViewContentInset() {
        let viewHeight: CGFloat = frame.size.height
        let tableViewContentHeight: CGFloat = tableView.contentSize.height
        let marginHeight: CGFloat = (viewHeight - tableViewContentHeight) / 2.0

        if marginHeight > 0 {
            self.tableView.contentInset = UIEdgeInsets(top: marginHeight, left: 0, bottom:  -marginHeight, right: 0)
        }
    }

    func reload() {
        tableView.reloadData()
        updateTableViewContentInset()
    }
}

extension DTListView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: BaseContainerCell<DTListItemView> = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as? BaseContainerCell<DTListItemView> else {
            return UITableViewCell()
        }

        let item = timesList[indexPath.row]
        cell.innerView.set(name: item.name ?? "", time: item.time ?? "")
        cell.innerView.isSelected(indexPath.row == 0)
        cell.separatorInset.left = indexPath.row == timesList.count-1 ? tableView.frame.width : 0
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timesList.count
    }
}

extension DTListView: CleanableView {
    var contentInset: UIEdgeInsets { UIEdgeInsets(top: 32, left: 32, bottom: -32, right: -32)}
    func clean() {}
}
