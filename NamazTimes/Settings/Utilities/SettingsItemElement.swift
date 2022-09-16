//
//  File.swift
//  Namaz Times
//
//  Created by &&TairoV on 01.09.2022.
//

import UIKit

struct SettingsTableSection {
    var title: String?
    var description: String?
    var elements: SettingsSection
}

typealias SettingsSection = [SettingsItemElement]

struct SettingsItemElement {
    var icon: UIImage?
    var title: String
    var accessoryImage: UIImage?
    var description: String?
    var fieldType: SettingsItemFieldType
}

enum SettingsItemFieldType {
    case location, language, aboutUs
}
