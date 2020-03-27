//
//  WeatherError.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import Foundation

enum WeatherError: Error {
    case invalidURL
    case requestFailed
    case badStatusCode(Int)
    case badDataRetrieved
    case parsingFailed
}
