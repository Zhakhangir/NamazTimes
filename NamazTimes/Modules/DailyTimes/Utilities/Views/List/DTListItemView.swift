//
//  DTTableCell.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import UIKit

class DTListItemView: UIView {

    let prayerName: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.font = .systemFont(dynamicSize: 18, weight: .regular)
        label.textColor = GeneralColor.black.withAlphaComponent(0.7)
        return label
    }()

    let prayerTime: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: 18, weight: .regular)
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

    func set(name: String = "-", time: String = "-" ) {
        prayerName.text = name
        prayerTime.text = time
    }

    func isSelected(_ selected: Bool = false) {
        prayerName.font = selected ? .systemFont(dynamicSize: 18, weight: .medium) : .systemFont(dynamicSize: 18, weight: .regular)
        prayerTime.font = selected ? .systemFont(dynamicSize: 18, weight: .medium) : .systemFont(dynamicSize: 18, weight: .regular)
        
        backgroundColor = selected ? GeneralColor.selected : .white
    }
}

extension DTListItemView: CleanableView {

    func clean() { }
}
