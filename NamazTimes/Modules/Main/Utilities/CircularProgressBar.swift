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
    let radius = (UIScreen.main.bounds.width / 2 - 40)

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
            innerView.centerYAnchor.constraint(equalTo: centerYAnchor),
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
