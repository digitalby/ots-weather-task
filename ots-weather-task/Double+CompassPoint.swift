//
//  Double+CompassPoint.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import Foundation

extension Double {
    var compassPoint: String? {
        let cardinals = ["N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"]
        let sector = (self.truncatingRemainder(dividingBy: 360.0)) / 45.0
        let index = sector.roundInt
        return cardinals[index]
    }
}
