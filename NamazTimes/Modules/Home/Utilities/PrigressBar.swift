//
//  PrigressBar.swift
//  Namaz Times
//
//  Created by &&TairoV on 21.09.2022.
//

import UIKit

class ProgressBar: UIView {
    
    let bar = CircularProgressBarView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
            addSubview(bar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
