//
//  GeneralViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 5/14/22.
//

import UIKit
import Lottie

class GeneralViewController: UIViewController, GeneralViewControllerProtocol {
    
    var timer = Timer()
    var localDate: Date { Date() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        runTimer()
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(secondRefresh), userInfo: nil, repeats: true)
        timer.fire()
        RunLoop.current.add(timer, forMode: .default)
    }
    
    @objc public func secondRefresh() { }
}
