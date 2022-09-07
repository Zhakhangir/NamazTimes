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

    private let timesList = DTListView()
    
    private let currentTime: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .monospacedDigitSystemFont(dynamicSize: 24, weight: .regular)

        return label
    }()

    private let currentTimeStatus: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = GeneralColor.el_subtitle
        label.font = .systemFont(dynamicSize: 16, weight: .regular)

        return label
    }()

    private lazy var currentTimeStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [currentTimeStatus, currentTime])
        stackView.axis = .vertical
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureTimes()
        addSubviews()
        setupLayout()
        stylize()
    }

    private func addSubviews() {
        contentView.addSubview(circularProgressBar)
        contentView.addSubview(currentTimeStack)

        if UIScreen.main.bounds.height > 700 {
            contentView.addSubview(timesList)
        }
    }

    private func setupLayout() {
        var layoutConstraints = [NSLayoutConstraint]()
        let list = interactor?.getTimesList() ?? [PrayerTimesList]()
        circularProgressBar.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            circularProgressBar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            circularProgressBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: (150 + 10 + 50))
        ]

        currentTimeStack.translatesAutoresizingMaskIntoConstraints = false
        timesList.translatesAutoresizingMaskIntoConstraints = false
        if UIScreen.main.bounds.height > 700 {
            layoutConstraints += [
                timesList.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                timesList.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                timesList.heightAnchor.constraint(equalToConstant: CGFloat(36*list.count))
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
        timesList.set(data: interactor?.getTimesList() ?? [PrayerTimesList]())
        timesList.set(rowHeight: 36)
        currentTimeStatus.text = "Local time"
        circularProgressBar.setTimaValues(currentTime: "Ogle", nextTime: "Kearahet 13:00")
    }

    private func configureTimes() {
        let annualTime = interactor?.getAnnualTimes()
        (parent as? GeneralTabBarViewController)?.navigationView.titleLabel.text = annualTime?.cityName

    }

    override func secondRefresh() {
        interval -= 1
        progress += 1
        currentTime.text = Date().timeString(withFormat: .full)
        circularProgressBar.updateReminingTime(interval: interval, nextTime: "Kerahet", allTime: allTime, progress: progress)
    }
}

extension HomeViewController: HomeViewInput {}
