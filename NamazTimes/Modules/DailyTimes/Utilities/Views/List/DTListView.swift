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
        tableView.register(DTListItemCell.self, forCellReuseIdentifier: cellReuseId)

        return tableView
    }()

    convenience init(mode: DeviceSize = .big) {
        self.init(frame: .zero)
        self.mode = mode

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
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

    func updateTableViewContentInset() {
        let viewHeight: CGFloat = bounds.size.height
        let tableViewContentHeight: CGFloat = tableView.contentSize.height
        let marginHeight: CGFloat = (viewHeight - tableViewContentHeight) / 2.0

        self.tableView.contentInset = marginHeight > 0 ?
        UIEdgeInsets(top: marginHeight, left: 0, bottom:  -marginHeight, right: 0):
        UIEdgeInsets(top: 0, left: 0, bottom:  0, right: 0)

    }

    func reload() {
        tableView.reloadData()
        updateTableViewContentInset()
    }
}

extension DTListView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: DTListItemCell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as? DTListItemCell else {
            return UITableViewCell()
        }

        let item = timesList[indexPath.row]
        cell.configure(viewModel: item, mode: mode)
        cell.separatorInset.left = indexPath.row == timesList.count-1 ? tableView.frame.width : 0
        if item.isCurrent {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        
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
