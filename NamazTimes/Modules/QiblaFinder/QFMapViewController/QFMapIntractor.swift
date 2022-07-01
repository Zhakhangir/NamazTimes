//
//  QFMapIntractor.swift.swift
//  NamazTimes
//
//  Created by &&TairoV on 30.05.2022.
//

import Foundation
import MapKit

class QFMapInteractor: QFMapInteractorInput {

    private var view: QFMapViewInput?


    private let locationMen = LocationMen()

    private var coordinates = [CLLocationCoordinate2D]()
    let KaabaCordinates = CLLocationCoordinate2D(latitude: 21.4216, longitude: 39.8248)

    init(view: QFMapViewInput) {
        self.view = view

    }

    func getUserLocation() -> CLLocationCoordinate2D {
        var location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            locationMen.getCurrentUserPosition { lat,long in
                if let lat = lat, let long = long {
                    location.latitude = lat
                    location.longitude = long
                }
            }

        return location
    }

}
