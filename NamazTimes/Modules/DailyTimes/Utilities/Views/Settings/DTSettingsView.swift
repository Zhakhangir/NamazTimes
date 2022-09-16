//
//  DailyTimesSettingsCollectionCell.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.05.2022.
//

import UIKit

class DTSettingsView: UIView {

    var settingsDidChanged: ((_ value: Bool, _ index: IndexPath)-> Void)?

    private var timesList = [PrayerTimesList]()
    private let cellReuseId  = "DTSettingsCell"
    private let requiredTimes: [PrayerTimes] = GeneralStorageController.shared.getRequiredList()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = 48
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = nil
        tableView.tableFooterView = nil
        tableView.register(BaseContainerCell<DTSettingsItemView>.self, forCellReuseIdentifier: cellReuseId)
        
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
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
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
        let enabled = !requiredTimes.contains(where: {$0.code.localized == item.name ?? ""})
        cell.innerView.set(name: item.name ?? "", isHidden: item.isHidden, switchEnabled: enabled)
        cell.separatorInset.left = indexPath.row == timesList.count-1 ? tableView.frame.width : 0
        cell.innerView.switchDidChangeAction = { [weak self]  value in
            self?.settingsDidChanged?(value, indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timesList.count
    }
}

extension DTSettingsView: CleanableView {

    var contentInset: UIEdgeInsets { UIEdgeInsets(top: 32, left: 32, bottom: -32, right: -32)}

    func clean() { }
}
