//
//  DailyTimesSettingsCollectionCell.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.05.2022.
//

import UIKit

class DTSettingsView: UIView {
    
    private var timesList = [PrayerTimesList]()
    private let cellReuseId  = "DTSettingsCell"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = 48
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false

        tableView.register(BaseContainerCell<DTSettingsItemView>.self, forCellReuseIdentifier: cellReuseId)
        
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
        tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48)
        ])
    }
    
    func set(data: [PrayerTimesList]) {
        timesList = data
        tableView.reloadData()
    }
}

extension DTSettingsView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: BaseContainerCell<DTSettingsItemView> = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as? BaseContainerCell<DTSettingsItemView> else {
            return UITableViewCell()
        }
        
        let item = timesList[indexPath.row]
        cell.innerView.set(name: item.name ?? "", isOn: item.show)
        if indexPath.row == (timesList.count - 1) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timesList.count
    }
}

extension DTSettingsView: CleanableView {

    func clean() { }
}
