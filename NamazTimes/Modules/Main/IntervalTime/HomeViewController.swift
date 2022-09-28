//
//  HomeViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit
import RealmSwift

protocol HomeViewInput where Self: UIViewController { }

class HomeViewController: UIViewController {

    var allTime = TimeInterval(4000)
    var interval = TimeInterval(4000)
    var progress = TimeInterval(1000)
    var interactor: HomeInteractorInput?
    var router: HomeRouterInput?
    
    var timer = Timer()
    var localDate: Date { Date() }

    private let circularProgressBar = CircularProgressBarView()
    private let prayerTimeInfo = 3
    private let parayerCellReuseId = "PrayerTimeCell"

    private let timesList: DTListView = {
        let list = DTListView(mode: .small)
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

        if DeviceType.heightType == .big {
            view.addSubview(timesList)
        }
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
            circularProgressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            circularProgressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            circularProgressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        currentTimeStack.translatesAutoresizingMaskIntoConstraints = false
        timesList.translatesAutoresizingMaskIntoConstraints = false
        if DeviceType.heightType == .big {
            
            layoutConstraints += [
                circularProgressBar.bottomAnchor.constraint(equalTo: timesList.topAnchor),
                circularProgressBar.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width/2) * 1.5)
            ]
            
            layoutConstraints += [
                timesList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                timesList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            ]

            layoutConstraints += [
                currentTimeStack.centerYAnchor.constraint(equalTo: timesList.centerYAnchor),
                currentTimeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                currentTimeStack.leadingAnchor.constraint(equalTo: timesList.trailingAnchor, constant: 16)
            ]
        } else {
            layoutConstraints += [
                currentTimeStack.topAnchor.constraint(equalTo: circularProgressBar.bottomAnchor),
                currentTimeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                currentTimeStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
                currentTimeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ]
        }

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        timesList.set(data: interactor?.getTimesList() ?? [DailyPrayerTime]())
        timesList.set(rowHeight: 40)
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

extension HomeViewController: HomeViewInput {}
