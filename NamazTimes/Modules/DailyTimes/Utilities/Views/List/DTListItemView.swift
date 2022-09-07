//
//  DTTableCell.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import UIKit

class DTListItemView: UIView {

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
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }

    func configure(viewModel: PrayerTimesList, mode: DeviceSize) {
        dynamicFontSize = mode == .big ? 22 : 18
        backgroundColor = viewModel.isSelected ? GeneralColor.selected : .white

        prayerName.font = viewModel.isSelected ? .systemFont(dynamicSize: dynamicFontSize, weight: .medium) : .systemFont(dynamicSize: dynamicFontSize, weight: .regular)
        prayerTime.font = viewModel.isSelected ? .systemFont(dynamicSize: dynamicFontSize, weight: .medium) : .systemFont(dynamicSize: dynamicFontSize, weight: .regular)

        prayerName.text = viewModel.name
        prayerTime.text = viewModel.time

    }
}

extension DTListItemView: CleanableView {

    func clean() { }
}
