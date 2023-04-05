//
//  CircularProgressBar.swift
//  Namaz Times
//
//  Created by &&TairoV on 22.08.2022.
//

import UIKit

class CircularProgressBarView: UIView {

    private let progressLayer = CAShapeLayer()
    private let secondaryLayer = CAShapeLayer()
    private let startPoint = CGFloat(5*Double.pi/6)
    private let endPoint = CGFloat(Double.pi/6)
    private let radius = (UIScreen.main.bounds.width / 2 - 24)

    let innerView = CircularProgressBarInnerView()

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
            innerView.topAnchor.constraint(equalTo: topAnchor, constant: 48),
            innerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            innerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            innerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    private func createCircularPath() {

        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        
        secondaryLayer.strokeColor = GeneralColor.primary.cgColor.copy(alpha: 0.5)
        secondaryLayer.path = circularPath.cgPath
        secondaryLayer.fillColor = UIColor.clear.cgColor
        secondaryLayer.lineWidth = 13.0
        layer.addSublayer(secondaryLayer)

        progressLayer.strokeColor = GeneralColor.primary.cgColor
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 13.0
        layer.addSublayer(progressLayer)
    }
    
    override func layoutSubviews() {
        secondaryLayer.position = CGPoint(x: bounds.midX, y: radius + 11)
        progressLayer.position = CGPoint(x: bounds.midX, y: radius + 11)
    }
    
    func configureInnerView(with data: DailyPrayerTime?) {
        innerView.configure(with: data)
    }
    
    func updateTimer(progress: Double, remining: Int) {
        innerView.updateReminingTime(interval: remining)
        progressLayer.strokeEnd = progress
    }
    
    func getProgressLayerBox() -> CGRect {
       return secondaryLayer.path?.boundingBox ?? CGRect(x: 0, y: 0, width: 0, height: 0)
    }
}
