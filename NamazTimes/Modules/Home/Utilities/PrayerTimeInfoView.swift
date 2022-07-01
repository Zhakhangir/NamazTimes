//
//  PrayerTimeInfoView.swift.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import UIKit

class PrayerTimeInfoView: UIView {

    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textColor = GeneralColor.secondary
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        addSubview(label)

        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func set(attributedText: NSAttributedString) {
        label.attributedText = attributedText
    }

    func set(text: String) {
        label.text = text
    }
}

extension PrayerTimeInfoView: CleanableView {
    func clean() { }

    var contentInset: UIEdgeInsets { UIEdgeInsets(top: 25, left: 16, bottom: 25, right: 16) }
}
