//
//  DTTableCell.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import UIKit

class DTListItemCell: UITableViewCell {

    private var dynamicFontSize: CGFloat = 22

    lazy var prayerName: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.textColor = GeneralColor.black.withAlphaComponent(0.7)
        return label
    }()

    lazy var prayerTime: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: dynamicFontSize, weight: .regular)
        label.textAlignment = .right
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.textColor = GeneralColor.black.withAlphaComponent(0.7)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [prayerName, prayerTime])
        stackView.axis = .horizontal
        stackView.contentMode = .center
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        configureSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        backgroundColor = selected ? GeneralColor.selected : .white
        prayerName.font = selected ? .systemFont(dynamicSize: dynamicFontSize, weight: .medium) : .systemFont(dynamicSize: dynamicFontSize, weight: .regular)
        prayerTime.font = selected ? .systemFont(dynamicSize: dynamicFontSize, weight: .medium) : .systemFont(dynamicSize: dynamicFontSize, weight: .regular)
    }

    func configure(viewModel: DailyPrayerTime, mode: DeviceSize) {
        dynamicFontSize = mode == .big ? 20 : 18
        prayerName.text = viewModel.code?.localized
        prayerTime.text = viewModel.time

    }
}
