//
//  LocationManager.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import CoreLocation
import UIKit

class LocationManager: CLLocationManager {
    private let onUpdate: (CLLocation)->()
    private let onError: (Error)->()

    init(onUpdate: @escaping (CLLocation)->(), onError: @escaping (Error)->()) {
        self.onUpdate = onUpdate
        self.onError = onError
        super.init()
        delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        onUpdate(locations.last!)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        onError(error)
    }
}
