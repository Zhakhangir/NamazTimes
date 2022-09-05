//
//  CircularProgressBar.swift
//  Namaz Times
//
//  Created by &&TairoV on 22.08.2022.
//

import UIKit

class CircularProgressBarView: UIView {

    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(5 * Double.pi / 4)
    private var endPoint = CGFloat(7 * Double.pi / 4)
    var totalDuration = 0

    let innerView = ProgressBarInnerView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

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
            innerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            innerView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func createCircularPath() {

        let radius = ((UIScreen.main.bounds.width / 2) - 30)
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 5*Double.pi/6, endAngle: Double.pi/6, clockwise: true)

        let greyLayer = CAShapeLayer()
        greyLayer.strokeColor = GeneralColor.primary.cgColor.copy(alpha: 0.5)
        greyLayer.lineWidth = 13.0
        greyLayer.path = circularPath.cgPath
        greyLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(greyLayer)

        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 13.0
        progressLayer.strokeColor = GeneralColor.primary.cgColor
        layer.addSublayer(progressLayer)
    }

    func setTimaValues(currentTime: String, nextTime: String) {
        innerView.setTimaValues(currentTime: currentTime, nextTime: nextTime)
    }

    func updateReminingTime(interval: TimeInterval, nextTime: String, allTime: TimeInterval, progress: TimeInterval) {
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
