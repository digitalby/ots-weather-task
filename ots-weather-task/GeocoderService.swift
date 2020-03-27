//
//  GeocoderService.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import CoreLocation
import Foundation

class GeocoderService {
    let geocoder = CLGeocoder()

    func geocodeCity(location: CLLocation, completion: @escaping (String?, Error?)->()) {
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let first = placemarks?.first else {
                completion(nil, CLError.geocodeFoundNoResult as? Error)
                return
            }
            completion(first.locality, nil)
        }
    }
}
