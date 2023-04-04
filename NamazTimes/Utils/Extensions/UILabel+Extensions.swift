//
//  UILabel+Extensions.swift
//  NamazTimes
//
//  Created by &&TairoV on 03.04.2023.
//

import UIKit

extension UILabel {
    func addCharacterSpacing(kernValue: Double = 1.15) {
        guard let text = text, !text.isEmpty else { return }
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: string.length - 1))
        attributedText = string
      }
}
