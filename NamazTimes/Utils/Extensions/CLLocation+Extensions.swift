//
//  CLLocation+Extension.swift
//  Namaz Times
//
//  Created by &&TairoV on 31.07.2022.
//

import UIKit
import MapKit

extension CLLocation {
    
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ region: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.administrativeArea, $0?.first?.country, $1)
        }

    }

    func getLongLatString() -> String {
        return String(format: "%.5f", self.coordinate.latitude) + " " + String(format: "%.5f", self.coordinate.longitude)
    }
}
