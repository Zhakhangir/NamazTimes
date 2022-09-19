//
//  DailyTimesSettingsCollectionCell.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.05.2022.
//

import UIKit

class DTSettingsView: UIView {

    var settingsDidChanged: ((_ value: Bool, _ index: IndexPath)-> Void)?

    private var timesList = [DailyPrayerTime]()
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        reload()
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
        tableView.reloadData()
    }
}

extension DTSettingsView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: BaseContainerCell<DTSettingsItemView> = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as? BaseContainerCell<DTSettingsItemView> else {
            return UITableViewCell()
        }
        
        let item = timesList[indexPath.row]
        cell.innerView.set(name: item.code?.localized ?? "", isHidden: item.isHidden)
        cell.separatorInset.left = indexPath.row == timesList.count-1 ? tableView.frame.width : 0
        cell.innerView.switchDidChangeAction = { [weak self]  value in
            self?.settingsDidChanged?(value, indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timesList.count
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

extension DTSettingsView: CleanableView {

    var contentInset: UIEdgeInsets { UIEdgeInsets(top: 32, left: 32, bottom: -32, right: -32)}

    func clean() { }
}
