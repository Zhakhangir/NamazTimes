//
//  DTSettingsTableCell.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import UIKit

class DTSettingsItemView: UIView {

    private let namazName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = GeneralColor.secondary
        return label
    }()

    private let switcher = UISwitch()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [namazName, switcher])
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
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func set(name: String = "-", isOn: Bool = false ) {
        namazName.text = name
        switcher.isOn = isOn
    }
}

extension DTSettingsItemView: CleanableView {

    func clean() { }
}


