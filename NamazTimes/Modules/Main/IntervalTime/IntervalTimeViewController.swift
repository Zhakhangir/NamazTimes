//
//  HomeViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit
import RealmSwift

protocol IntervalTimeViewInput where Self: UIViewController {
    func setTimer()
    func reload()
}

class IntervalTimeViewController: UIViewController {
    
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
    
    private let miladMonth : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = GeneralColor.primary
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.font = .systemFont(dynamicSize: 16, weight: .semibold)

        return label
    }()
    
    private let hijriMonth : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = GeneralColor.primary
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.font = .systemFont(dynamicSize: 16, weight: .semibold)
        
        return label
    }()
    
    private let currentTime: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .monospacedDigitSystemFont(dynamicSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()

    private let currentTimeStatus: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(dynamicSize: 16, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()

    private lazy var currentTimeStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [miladMonth, hijriMonth, currentTimeStatus, currentTime])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.setCustomSpacing(32, after: hijriMonth)
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        timesList.backgroundColor = .clear
    
        addSubviews()
        setupLayout()
        stylize()
        reload()
        runTimer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let interactor = interactor else { return }
        let status = interactor.getCurrentProgressStatus()
        circularProgressBar.configureInnerView(with: interactor.getCurrentTime())
        circularProgressBar.updateTimer(progress: status.progress, remining: status.remining)
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
        let box = circularProgressBar.getProgressLayerBox()
        
        circularProgressBar.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            circularProgressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circularProgressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64 + (DeviceType.heightType == .big ? 32 : 8)),
            circularProgressBar.widthAnchor.constraint(equalToConstant: box.width),
            circularProgressBar.heightAnchor.constraint(equalToConstant:  box.height)
        ]

        currentTimeStack.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            currentTimeStack.centerYAnchor.constraint(equalTo: timesList.centerYAnchor),
            currentTimeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            currentTimeStack.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8)
        ]
        
        
        timesList.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            timesList.topAnchor.constraint(equalTo: circularProgressBar.bottomAnchor, constant: 16),
            timesList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timesList.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),
            timesList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: DeviceType.heightType == .big ? -32 : -16)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        let dateNames = interactor?.getDateNames()
        currentTimeStatus.text = "local_time".localized
        miladMonth.text = dateNames?.dateName
        hijriMonth.text = dateNames?.islamicDateName
    }

    @objc private func secondRefresh() {
        currentTime.text = Date().timeString(withFormat: .full)
        
        guard let interactor = interactor else { return }
        let status = interactor.getCurrentProgressStatus()
        interactor.didUpdateTimer()
        circularProgressBar.updateTimer(progress: status.progress, remining: status.remining)
        print(status)
        if status.remining == 0 {
            interactor.didFinishTimer()
        }
    }
    
    deinit {
        timer.invalidate()
    }
}

extension IntervalTimeViewController: IntervalTimeViewInput {
    
    func reload() {
        guard let interactor = interactor else { return }
        timesList.reload(with: interactor.getTimesList())
        let status = interactor.getCurrentProgressStatus()
        circularProgressBar.configureInnerView(with: interactor.getCurrentTime())
        circularProgressBar.updateTimer(progress: status.progress, remining: status.remining)
    }
    
    func setTimer() {
        
    }
}
