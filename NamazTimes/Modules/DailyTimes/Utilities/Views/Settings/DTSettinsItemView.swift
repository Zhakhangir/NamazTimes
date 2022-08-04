//
//  DTSettingsTableCell.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import UIKit

class DTSettingsItemView: UIView {

    private let prayerName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .regular)
        label.textColor = GeneralColor.black
        return label
    }()

    private let switcher: UISwitch = {
        let switcher = UISwitch()

        switcher.onTintColor = GeneralColor.primary
        return switcher
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [prayerName, switcher])
        stackView.axis = .horizontal
        stackView.alignment = .center
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
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
    }

    func set(name: String = "-", isOn: Bool = false ) {
        prayerName.text = name
        switcher.isOn = isOn
    }
}

extension DTSettingsItemView: CleanableView {

    func clean() { }
}


