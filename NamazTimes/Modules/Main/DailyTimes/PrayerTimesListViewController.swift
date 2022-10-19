//
//  DailyTimesListViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit

protocol PrayerTimesListViewInput where Self: UIViewController {
    func reload()
}

class PrayerTimesListViewController: UIViewController {
   
    var router: PrayerTimesListRouterInput?
    var interactor: PrayerTimesListIntercatorInput?
    
    private let timesList = PrayerTimesListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        reload()
    }
    
    private func configureSubviews() {
        view.addSubview(timesList)
        
        timesList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timesList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 32 + 64),
            timesList.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32),
            timesList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            timesList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
}

extension PrayerTimesListViewController: PrayerTimesListViewInput {
    
    func reload() {
        timesList.reload(with: interactor?.getData() ?? [DailyPrayerTime]())
    }
}
