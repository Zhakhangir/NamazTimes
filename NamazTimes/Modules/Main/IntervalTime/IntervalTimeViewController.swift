//
//  HomeViewController.swift
//  NamazTimes
//
//  Created by &&TairoV on 4/20/22.
//

import UIKit
import RealmSwift

protocol IntervalTimeViewInput where Self: UIViewController {
    func reload()
    func reloadCalendar()
    func showAlert(with model: GeneralAlertModel)
}

class IntervalTimeViewController: UIViewController {
    
    var interactor: IntervalTimeInteractorInput?
    var router: IntervalTimeRouterInput?
    
    var timer = Timer()
    var localDate: Date { Date() }
    private let gregorianCalendar = CalendarView()
    private let hijriCalendar = CalendarView()
    private let circularProgressBar = CircularProgressBarView()
    private let parayerCellReuseId = "PrayerTimeCell"
    
    private let timesList: PrayerTimesListView = {
        let list = PrayerTimesListView()
        list.isUserInteractionEnabled = false
        list.addBorderToTable()
        return list
    }()
    
    private let currentTime: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = .monospacedDigitSystemFont(dynamicSize: 20, weight: .semibold)
        return label
    }()
    
    private let weekDay: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = .systemFont(dynamicSize: 20, weight: .medium)
        label.textColor = GeneralColor.primary
        return label
    }()
    
    private lazy var calendarStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [hijriCalendar, gregorianCalendar])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    private lazy var currentTimeStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [weekDay, currentTime])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timesList.backgroundColor = .clear
        hijriCalendar.icon.image = UIImage(named: "hijri_calendar")
        gregorianCalendar.icon.image = UIImage(named: "gregorian_calendar")
        
        addSubviews()
        setupLayout()
        reload()
        reloadCalendar()
        runTimer()
        interactor?.viewDidload()
    }
    
    private func addSubviews() {
        view.addSubview(circularProgressBar)
        view.addSubview(timesList)
        view.addSubview(calendarStack)
        view.addSubview(currentTimeStack)
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
        
        timesList.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            timesList.topAnchor.constraint(equalTo: circularProgressBar.bottomAnchor, constant: 8),
            timesList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            timesList.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),
            timesList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ]
        
        currentTimeStack.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            currentTimeStack.topAnchor.constraint(equalTo: timesList.topAnchor),
            currentTimeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            currentTimeStack.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8)
        ]
        
        calendarStack.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            calendarStack.topAnchor.constraint(greaterThanOrEqualTo: currentTimeStack.bottomAnchor, constant: 8),
            calendarStack.centerXAnchor.constraint(equalTo: currentTimeStack.centerXAnchor),
            calendarStack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24),
            calendarStack.leadingAnchor.constraint(greaterThanOrEqualTo: view.centerXAnchor, constant: 8),
            calendarStack.bottomAnchor.constraint(equalTo: timesList.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(secondRefresh), userInfo: nil, repeats: true)
        timer.fire()
        RunLoop.current.add(timer, forMode: .default)
    }
    
    @objc private func secondRefresh() {
        currentTime.text = Date().timeString(withFormat: .full)
        
        guard let interactor = interactor else { return }
        let status = interactor.getCurrentProgressStatus()
        interactor.didUpdateTimer()
        circularProgressBar.updateTimer(progress: status.progress, remining: status.remining)
        
        if status.remining == 0 {
            interactor.reloadTimer()
            NotificationCenter.default.post(name: Notification.Name(GeneralNotifications.DID_PRAYER_TIME_CHANGE.rawValue), object: nil)
        }
        
        if currentTime.text ?? "" == "00:00:00" {
            reloadCalendar()
        }
    }
    
    deinit {
        timer.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
}

extension IntervalTimeViewController: IntervalTimeViewInput {
    
    func showAlert(with model: GeneralAlertModel) {
        router?.showAlert(with: model)
    }
    
    func reloadCalendar() {
        guard let calendarViewModels = interactor?.getCalendarViewModels() else { return }
        gregorianCalendar.configure(with: calendarViewModels.gregorianCalendar)
        hijriCalendar.configure(with: calendarViewModels.hijriCalendar)
        weekDay.text = calendarViewModels.weekDay
    }
    
    func reload() {
        guard let interactor = interactor else { return }
        timesList.reload(with: interactor.getTimesList())
        let status = interactor.getCurrentProgressStatus()
        circularProgressBar.configureInnerView(with: interactor.getCurrentTime())
        circularProgressBar.updateTimer(progress: status.progress, remining: status.remining)
    }
}
