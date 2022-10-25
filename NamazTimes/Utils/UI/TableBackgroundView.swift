//
//  TableBackgroundView.swift
//  NamazTimes
//
//  Created by &&TairoV on 24.10.2022.
//

import UIKit
import Lottie

class TableBackgroundView: UIView {

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = GeneralColor.secondary
        return label
    }()
    private lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: "loader")
        animationView.animationSpeed = 1
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
        return animationView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        
        var layoutConstraints = [NSLayoutConstraint]()
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
}
