//
//  Coordinate.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import Foundation
import CoreLocation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

extension Coordinate {
    var clLocation: CLLocation { CLLocation(latitude: latitude, longitude: longitude) }
}
