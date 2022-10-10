//
//  CircularProgressBar.swift
//  Namaz Times
//
//  Created by &&TairoV on 22.08.2022.
//

import UIKit

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
            innerView.topAnchor.constraint(equalTo: topAnchor, constant: radius/2),
            innerView.centerXAnchor.constraint(equalTo: centerXAnchor)
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
        secondaryLayer.position = CGPoint(x: bounds.midX, y: (UIScreen.main.bounds.width / 2))
        progressLayer.position = CGPoint(x: bounds.midX, y: (UIScreen.main.bounds.width / 2))
    }

    func setTimaValues(currentTime: PrayerTimesInfo?, nextTime: PrayerTimesInfo?) {
        innerView.setTimaValues(currentTime: currentTime, nextTime: nextTime)
    }

    func updateReminingTime(interval: TimeInterval, nextTime: PrayerTimesInfo?, allTime: TimeInterval, progress: TimeInterval) {
        innerView.updateReminingTime(interval: interval, nextTime: nextTime)
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
}
