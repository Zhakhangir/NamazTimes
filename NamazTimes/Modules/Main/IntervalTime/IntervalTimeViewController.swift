//
//  HomeViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit
import RealmSwift

protocol IntervalTimeViewInput where Self: UIViewController { }

class IntervalTimeViewController: UIViewController {

    var allTime = TimeInterval(4000)
    var interval = TimeInterval(4000)
    var progress = TimeInterval(1000)
    
    var interactor: IntervalTimeInteractorInput?
    var router: IntervalTimeRouterInput?
    
    var timer = Timer()
    var localDate: Date { Date() }

    private let circularProgressBar = CircularProgressBarView()
    private let parayerCellReuseId = "PrayerTimeCell"

    private let timesList: PrayerTimesListView = {
        let list = PrayerTimesListView()
        list.isUserInteractionEnabled = false
        return list
    }()
    
    private let currentTime: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .monospacedDigitSystemFont(dynamicSize: 21, weight: .semibold)

        return label
    }()

    private let currentTimeStatus: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(dynamicSize: 18, weight: .light)

        return label
    }()

    private lazy var currentTimeStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [currentTimeStatus, currentTime])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        runTimer()
        addSubviews()
        setupLayout()
        stylize()
    }

    private func addSubviews() {
        view.addSubview(circularProgressBar)
        view.addSubview(currentTimeStack)
        view.addSubview(timesList)
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(secondRefresh), userInfo: nil, repeats: true)
        timer.fire()
        RunLoop.current.add(timer, forMode: .default)
    }

    private func setupLayout() {
        var layoutConstraints = [NSLayoutConstraint]()

        circularProgressBar.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            circularProgressBar.bottomAnchor.constraint(equalTo: timesList.topAnchor),
            circularProgressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            circularProgressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            circularProgressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            circularProgressBar.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width/2) * 1.5)
        ]

        currentTimeStack.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            currentTimeStack.centerYAnchor.constraint(equalTo: timesList.centerYAnchor),
            currentTimeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            currentTimeStack.leadingAnchor.constraint(equalTo: timesList.trailingAnchor, constant: 8)
        ]
        
        
        timesList.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            timesList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timesList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        timesList.set(data: interactor?.getTimesList() ?? [DailyPrayerTime]())
        currentTimeStatus.text = "local_time".localized
    }

    @objc private func secondRefresh() {
        interval -= 1
        progress += 1
        currentTime.text = Date().timeString(withFormat: .full)
        circularProgressBar.setTimaValues(currentTime:  interactor?.getCurrentNextTime().current, nextTime:  interactor?.getCurrentNextTime().next)
        circularProgressBar.updateReminingTime(interval: interval, nextTime:  interactor?.getCurrentNextTime().next, allTime: allTime, progress: progress)
    }
}

extension IntervalTimeViewController: IntervalTimeViewInput {}
