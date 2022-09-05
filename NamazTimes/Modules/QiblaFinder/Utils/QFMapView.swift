//
//  MapView.swift
//  NamazTimes
//
//  Created by &&TairoV on 30.05.2022.
//

import UIKit
import MapKit

class QFMapView: MKMapView {

    private var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close_icon"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()

    private var locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "location"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()

    private var mapTypeSegment: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = GeneralColor.primary
        return segmentedControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {

    }

    private func setupLayout() {

    }

    private func stylize() {

    }
}
