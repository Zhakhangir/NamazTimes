//
//  LanguageCell.swift
//  Namaz Times
//
//  Created by &&TairoV on 06.09.2022.
//

import UIKit

class LanguageCell: UITableViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()

    let icon = UIImageView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [icon, titleLabel])
        stackView.spacing = 8
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        configureSubview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubview() {
        contentView.addSubview(stackView)

        var layoutConstraints = [NSLayoutConstraint]()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]

        icon.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            icon.heightAnchor.constraint(equalToConstant: 18),
            icon.widthAnchor.constraint(equalToConstant: 24)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
    }

    func configure(viewModel: LanguageSettings) {
        titleLabel.text = viewModel.title
        icon.image = viewModel.icon
    }
}
