//
//  WeatherParser.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import Foundation

class WeatherParser {
    let decoder = JSONDecoder()

    func parseWeather(from data: Data) throws -> Weather {
        do {
            let weather = try decoder.decode(Weather.self, from: data)
            return weather
        } catch {
            throw WeatherError.parsingFailed
        }
    }
}
