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

            print("dfdf",$0?.first?.name) // eg. Apple Inc.
            print("dfdf",$0?.first?.thoroughfare) // street name, eg. Infinite Loop
            print("dfdf",$0?.first?.subThoroughfare) // eg. 1
            print("dfdf",$0?.first?.locality) // city, eg. Cupertino
            print("dfdf",$0?.first?.subLocality) // neighborhood, common name, eg. Mission District
            print("dfdf",$0?.first?.administrativeArea) // state, eg. CA
            print("dfdf",$0?.first?.subAdministrativeArea) // county, eg. Santa Clara
            print("dfdf",$0?.first?.postalCode) // zip code, eg. 95014
            print("dfdf",$0?.first?.isoCountryCode) // eg. US
            print("dfdf",$0?.first?.country) // eg. United States
            print("dfdf",$0?.first?.inlandWater) // eg. Lake Tahoe
            print("dfdf",$0?.first?.ocean) // eg. Pacific Ocean
            print("dfdf",$0?.first?.areasOfInterest) // eg. Golden Gate Park
        }

    }
}
