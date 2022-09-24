//
//  HomeViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit
import RealmSwift

protocol HomeViewInput: GeneralViewControllerProtocol { }

class HomeViewController: GeneralViewController {

    var allTime = TimeInterval(4000)
    var interval = TimeInterval(4000)
    var progress = TimeInterval(1000)
    var interactor: HomeInteractorInput?
    var router: HomeRouterInput?

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
    
    override func viewDidLayoutSubviews() {
//        circularProgressBar.frame = CGRect(x: contentView.center.x , y: contentView.center.y, width: contentView.bounds.width, height: contentView.bounds.height)
//        circularProgressBar.backgroundColor = .darkGray
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addSubviews()
        setupLayout()
        stylize()
    }

    private func addSubviews() {
        contentView.addSubview(circularProgressBar)
        contentView.addSubview(currentTimeStack)

        if DeviceType.heightType == .big {
            contentView.addSubview(timesList)
        }
    }

    private func setupLayout() {
        var layoutConstraints = [NSLayoutConstraint]()
        let listHeight = interactor?.getTimesListHeight() ?? 0

        circularProgressBar.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            circularProgressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            circularProgressBar.topAnchor.constraint(equalTo: contentView.topAnchor),
            circularProgressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            circularProgressBar.heightAnchor.constraint(equalToConstant:200)
//            circularProgressBar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            circularProgressBar.topAnchor.constraint(equalTo: contentView.topAnchor)
        ]

        currentTimeStack.translatesAutoresizingMaskIntoConstraints = false
        timesList.translatesAutoresizingMaskIntoConstraints = false
        if DeviceType.heightType == .big {
            layoutConstraints += [
                timesList.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                timesList.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                timesList.heightAnchor.constraint(equalToConstant: listHeight)
            ]

            layoutConstraints += [
                currentTimeStack.centerYAnchor.constraint(equalTo: timesList.centerYAnchor),
                currentTimeStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                currentTimeStack.leadingAnchor.constraint(equalTo: timesList.trailingAnchor, constant: 16)
            ]
        } else {
            layoutConstraints += [
                currentTimeStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                currentTimeStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
                currentTimeStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            ]
        }

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        timesList.set(data: interactor?.getTimesList() ?? [DailyPrayerTime]())
        timesList.set(rowHeight: 40)
        currentTimeStatus.text = "local_time".localized
    }

    override func secondRefresh() {
        interval -= 1
        progress += 1
        currentTime.text = Date().timeString(withFormat: .full)
        circularProgressBar.setTimaValues(currentTime:  interactor?.getCurrentNextTime().current, nextTime:  interactor?.getCurrentNextTime().next)
        circularProgressBar.updateReminingTime(interval: interval, nextTime:  interactor?.getCurrentNextTime().next, allTime: allTime, progress: progress)
    }
}

extension HomeViewController: HomeViewInput {}
