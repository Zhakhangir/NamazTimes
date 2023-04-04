//
//  CalendarView.swift
//  Namaz Times
//
//  Created by &&TairoV on 19.10.2022.
//

import UIKit

struct CalendarViewModel {
    var day: String?
    var month: String?
    var year: String?
}

class CalendarView: UIView {
    
    let icon = UIImageView()
    
    let year: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: 13, weight: .regular)
        label.textAlignment = .right
        label.textColor = .white
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let day: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: 24, weight: .medium)
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    let month: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: 16, weight: .regular)
        label.minimumScaleFactor = 0.1
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [year, day, month])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
        stylize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        addSubview(stackView)
        addSubview(icon)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: year.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            icon.heightAnchor.constraint(equalToConstant: 20),
            icon.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func stylize() {
        backgroundColor = GeneralColor.primary
        layer.cornerRadius = 16
        
        icon.contentMode = .scaleAspectFit
    }
    
    func configure(with viewModel: CalendarViewModel?) {
        day.text = viewModel?.day
        month.text = viewModel?.month
        year.text = viewModel?.year
    }
}
