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

        addSubviews()
        setupLayout()
        stylize()
    }

    override func viewDidLayoutSubviews() {

    }

    private func addSubviews() {
        contentView.addSubview(circularProgressBar)
        contentView.addSubview(currentTimeStack)
    }

    private func setupLayout() {
        var layoutConstraints = [NSLayoutConstraint]()

        circularProgressBar.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            circularProgressBar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            circularProgressBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: (150 + 10 + 50))
        ]

        currentTimeStack.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            currentTimeStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            currentTimeStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            currentTimeStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        currentTimeStatus.text = "Local time"
        circularProgressBar.setTimaValues(currentTime: "Ogle", nextTime: "Kearahet 13:00")
    }

    override func secondRefresh() {
        interval -= 1
        progress += 1
        currentTime.text = Date().timeString(withFormat: .full)
        circularProgressBar.updateReminingTime(interval: interval, nextTime: "Kerahet", allTime: allTime, progress: progress)
    }
}

extension HomeViewController: HomeViewInput {}
