//
//  CleanableView.swift
//  NamazTimes
//
//  Created by &&TairoV on 26.05.2022.
//

import UIKit

protocol CleanableView: UIView {
    var contentInset: UIEdgeInsets { get }
    var containerBackgroundColor: UIColor { get }
    func clean()
}

extension CleanableView {
    var contentInset: UIEdgeInsets { UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) }
    var containerBackgroundColor: UIColor { .clear }
}
