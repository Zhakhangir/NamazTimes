//
//  ProgressBarInnerView.swift
//  Namaz Times
//
//  Created by &&TairoV on 29.08.2022.
//

import UIKit

class CircularProgressBarInnerView: UIView {

    private var prayerInfo: DailyPrayerTime?
    
    private let topSeparator: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 0.7)
        layer.backgroundColor = GeneralColor.darkGray.cgColor.copy(alpha: 0.5)
        return layer
    }()
    private let bottomSeparator: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 0.7)
        layer.backgroundColor = GeneralColor.darkGray.cgColor.copy(alpha: 0.5)
        return layer
    }()

    private lazy var topSpace: UIView = {
        let view = UIView()
        view.layer.addSublayer(topSeparator)
        return view
    }()

    private lazy var bottomSpace: UIView = {
        let view = UIView()
        view.layer.addSublayer(bottomSeparator)
        return view
    }()

    var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .medium)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.textAlignment = .center
        label.textColor = GeneralColor.primary
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()

    var remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .regular)
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()

    var nextTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .regular)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            currentTimeLabel,
            topSpace,
            remainingTimeLabel,
            bottomSpace,
            nextTimeLabel
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        topSeparator.position = CGPoint(x: topSpace.bounds.midX, y: topSpace.bounds.midY)
        bottomSeparator.position = CGPoint(x: topSpace.bounds.midX, y: topSpace.bounds.midY)
    }

    private func configureSubviews() {
        addSubview(stackView)

        var layoutConstraints = [NSLayoutConstraint]()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]


        topSpace.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            topSpace.heightAnchor.constraint(equalToConstant: 10)
        ]

        bottomSpace.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            bottomSpace.heightAnchor.constraint(equalToConstant: 10)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    func configure(with data: DailyPrayerTime?) {
        prayerInfo = data
        currentTimeLabel.text = data?.code.localized
        nextTimeLabel.text = data?.nextCode.localized.concatenateWithSapce(data?.nextTime)
    }

    func updateReminingTime(interval: Int) {
        let attrString = NSMutableAttributedString()
        let paragraphStyle = NSMutableParagraphStyle()
        
        let nextTime = NSAttributedString(string: (prayerInfo?.nextCode.localized ?? "").concatenateWithSapce("remaining".localized), attributes: [ .font: UIFont.monospacedDigitSystemFont(dynamicSize: 20, weight: .light)])
        let reminigTime = NSAttributedString(string: getReminingTime(from: interval),
                                            attributes: [ .font: UIFont.monospacedDigitSystemFont(dynamicSize: 23, weight: .semibold) ])
        
        paragraphStyle.lineSpacing = 2
        paragraphStyle.lineHeightMultiple = 2
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        attrString.append(nextTime)
        attrString.append(reminigTime)
        remainingTimeLabel.attributedText = attrString

    }
    
    private func getReminingTime(from interval: Int) -> String {
        
        let time = NSInteger(interval)
        let seconds = (time % 60)
        let minutes = ((time / 60) % 60)
        let hours = (time / 3600)
        
        var string = "\n"
        
        if hours == 0 && minutes == 0 {
            return string + "\(seconds)".concatenateWithSapce("seconds".localized)
        } else if  hours == 0 && minutes >= 10 {
            return string + "\(minutes)".concatenateWithSapce("minutes".localized)
        } else if hours > 0 && minutes == 0 {
            return string + "\(hours)".concatenateWithSapce("hours".localized)
        }
            
        string += "\(hours == 0 ? minutes : hours)"
                  .concatenateWithSapce((hours == 0 ? "minutes".localized : "hours".localized))
                  .concatenateWithSapce("\((hours == 0 && minutes < 10) ? seconds : minutes)")
                  .concatenateWithSapce((hours == 0 && minutes < 10) ? "seconds".localized : "minutes".localized)
        
        return string
    }
}
