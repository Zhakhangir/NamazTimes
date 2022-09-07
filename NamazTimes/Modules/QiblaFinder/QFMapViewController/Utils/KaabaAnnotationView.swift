//
//  KaabaAnnotationView.swift
//  NamazTimes
//
//  Created by &&TairoV on 01.06.2022.
//

import Foundation
import MapKit

class KaabaAnnotaionView: MKAnnotationView {

    override var annotation: MKAnnotation? {
        willSet {
            self.image = UIImage(named: "kaaba")
        }
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        canShowCallout = true
    }
}
