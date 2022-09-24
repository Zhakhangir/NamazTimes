//
//  GeneralViewControllerProtocol.swift
//  NamazTimes
//
//  Created by &&TairoV on 5/14/22.
//

import UIKit

protocol GeneralViewControllerProtocol where Self: UIViewController {
    var timer: Timer { get }
    var localDate: Date { get }
    var contentView: UIView { get }
}
