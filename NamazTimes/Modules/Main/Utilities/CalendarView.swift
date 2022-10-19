//
//  CalendarView.swift
//  Namaz Times
//
//  Created by &&TairoV on 19.10.2022.
//

import UIKit

class CalendarView: UIView {
    
    let day: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: 40, weight: .medium)
        label.textAlignment = .center
        label.textColor = GeneralColor.primary
        label.adjustsFontForContentSizeCategory = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    
    let month: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: 40, weight: .medium)
        label.textAlignment = .center
        label.textColor = GeneralColor.primary
        label.adjustsFontForContentSizeCategory = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    
    let yaer: UILabel = {
        let label = UILabel()
        label.font = .systemFont(dynamicSize: 40, weight: .medium)
        label.textAlignment = .center
        label.textColor = GeneralColor.primary
        label.adjustsFontForContentSizeCategory = true
        label.minimumScaleFactor = 0.5
        return label
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
        addSubview(day)
        addSubview(month)
        addSubview(yaer)
        
        
    }
    
    private func stylize() {
        backgroundColor = GeneralColor.primary
        layer.cornerRadius = 16
    }
    
    
}
