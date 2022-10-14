//
//  CircularProgressBar.swift
//  Namaz Times
//
//  Created by &&TairoV on 22.08.2022.
//

import UIKit

enum ProgressBarStates {
    
    case waiting, red, normal
    
    var color: UIColor {
        switch self {
        case .waiting, .normal:
            return GeneralColor.primary
        case .red:
            return GeneralColor.red
        }
    }
}

class CircularProgressBarView: UIView {

    private var progressLayer = CAShapeLayer()
    let secondaryLayer = CAShapeLayer()
    private var startPoint = CGFloat(5*Double.pi/6)
    private var endPoint = CGFloat(Double.pi/6)
    let radius = (UIScreen.main.bounds.width / 2 - 30)
    var totalDuration = 0

    let innerView = ProgressBarInnerView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        createCircularPath()
        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(innerView)
        innerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
//            innerView.heightAnchor.constraint(equalToConstant: 200),
            innerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            innerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            innerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    private func createCircularPath() {

        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        
        secondaryLayer.strokeColor = GeneralColor.primary.cgColor.copy(alpha: 0.5)
        secondaryLayer.lineWidth = 11.0
        secondaryLayer.path = circularPath.cgPath
        secondaryLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(secondaryLayer)

        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 11.0
        progressLayer.strokeColor = GeneralColor.primary.cgColor
        layer.addSublayer(progressLayer)
    }
    
    override func layoutSubviews() {
        secondaryLayer.position = CGPoint(x: bounds.midX, y: radius + 11)
        progressLayer.position = CGPoint(x: bounds.midX, y: radius + 11)
    }

    func setTimeValues(currentTime: PrayerTimesInfo?, nextTime: PrayerTimesInfo?) {
        innerView.setTimaValues(currentTime: currentTime, nextTime: nextTime)
    }

    func updateReminingTime(reminingTime: TimeInterval, nextTime: PrayerTimesInfo?, allTime: TimeInterval, progress: TimeInterval) {
        innerView.updateReminingTime(interval: reminingTime, nextTime: nextTime)
        progressLayer.strokeEnd = Double(progress/allTime)
    }

    func progressAnimation(duration: TimeInterval) {
//        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        circularProgressAnimation.duration = duration
//        circularProgressAnimation.fromValue = 0.5
//        circularProgressAnimation.toValue = 1
//        circularProgressAnimation.fillMode = .forwards
//        circularProgressAnimation.isRemovedOnCompletion = false
//        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
    
    func getProgressLayerBox() -> CGRect {
       return secondaryLayer.path?.boundingBox ?? CGRect(x: 0, y: 0, width: 0, height: 0)
    }
}
