//
//  QFMapIntractor.swift.swift
//  NamazTimes
//
//  Created by &&TairoV on 30.05.2022.
//

import Foundation
import MapKit

protocol QFMapInteractorInput {
    func getUserLocation() -> CLLocationCoordinate2D
}


class QFMapInteractor: QFMapInteractorInput {

    private var view: QFMapViewInput?

    private var coordinates = [CLLocationCoordinate2D]()
    let KaabaCordinates = CLLocationCoordinate2D(latitude: 21.4216, longitude: 39.8248)

    init(view: QFMapViewInput) {
        self.view = view
        LocationService.sharedInstance.delegate = self
    }

    func getUserLocation() -> CLLocationCoordinate2D {
        LocationService.sharedInstance.currentLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
}

extension QFMapInteractor: LocationServiceDelegate {

    func tracingHeading(heading: CLHeading) { }

    func tracingLocation(currentLocation: CLLocation) { }

    func tracingLocationDidFailWithError(error: NSError) { }
}

