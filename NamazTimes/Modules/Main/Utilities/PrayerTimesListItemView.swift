//
//  DTTableCell.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import UIKit

class PrayerTimesListItemView: UIView {

    private var dynamicFontSize: CGFloat = 22

    lazy var prayerName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: dynamicFontSize, weight: .regular)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.textColor = GeneralColor.black.withAlphaComponent(0.7)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var prayerTime: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: dynamicFontSize, weight: .medium)
        label.textAlignment = .right
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.textColor = GeneralColor.black.withAlphaComponent(0.7)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [prayerName, prayerTime])
        stackView.axis = .horizontal
        stackView.contentMode = .center
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
    func setSelected(_ selected: Bool) {
        backgroundColor = selected ? GeneralColor.selected : .white
        prayerName.font = selected ? .systemFont(dynamicSize: dynamicFontSize, weight: .medium) : .systemFont(dynamicSize: dynamicFontSize, weight: .regular)
        prayerTime.font = selected ? .systemFont(dynamicSize: dynamicFontSize, weight: .medium) : .systemFont(dynamicSize: dynamicFontSize, weight: .regular)
    }

    func configure(viewModel: DailyPrayerTime) {
        dynamicFontSize = DeviceType.heightType == .big ? 20 : 18
        prayerName.text = viewModel.code.localized
        prayerTime.text = viewModel.startTime
        setSelected(viewModel.selected)
    }
}

extension PrayerTimesListItemView: CleanableView {
    
    func clean() { }
}
