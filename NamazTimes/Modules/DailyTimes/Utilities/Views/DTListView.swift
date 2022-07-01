//
//  DailyTimesListCollectionCell.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.05.2022.
//

import UIKit

class DTListView: UIView {

    private var timesList = [NamazTimesList]()
    private let cellReuseId  = "DTListCell"

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = 48
        tableView.separatorInset = UIEdgeInsets.zero
        
        tableView.register(BaseContainerCell<DTListItemView>.self, forCellReuseIdentifier: cellReuseId)

        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureSubviews()
        tableView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }

    func set(data: [NamazTimesList]) {
        timesList = data
        tableView.reloadData()
    }
}

extension DTListView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: BaseContainerCell<DTListItemView> = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as? BaseContainerCell<DTListItemView> else {
            return UITableViewCell()
        }

        let item = timesList[indexPath.row]
        cell.innerView.set(name: item.name, time: item.time)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timesList.count
    }
}

extension DTListView: CleanableView {
    
    func clean() {}
}
