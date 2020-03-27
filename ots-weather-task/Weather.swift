//
//  Weather.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let latitude: Double
    let longitude: Double
    let description: String?
    let temperature: Double?
    let feelsLike: Double?
    let temperatureMin: Double?
    let temperatureMax: Double?
    let pressure: Double?
    let humidity: Double?
    let windSpeed: Double?
    let windDeg: Double?
    //UTC time
    let sunrise: Date?
    //UTC time
    let sunset: Date?
    let timezone: TimeZone?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let coordContainer = try container.nestedContainer(keyedBy: CoordKeys.self, forKey: .coord)
        latitude = try coordContainer.decode(Double.self, forKey: .lat)
        longitude = try coordContainer.decode(Double.self, forKey: .lon)
        let weatherData: [InnerWeather] = try container.decode([InnerWeather].self, forKey: .weather)
        description = weatherData.first?.description ?? ""
        let mainContainer = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temperature = try mainContainer.decodeIfPresent(Double.self, forKey: .temp)
        temperatureMin = try mainContainer.decodeIfPresent(Double.self, forKey: .tempMin)
        temperatureMax = try mainContainer.decodeIfPresent(Double.self, forKey: .tempMax)
        pressure = try mainContainer.decodeIfPresent(Double.self, forKey: .pressure)
        humidity = try mainContainer.decodeIfPresent(Double.self, forKey: .humidity)
        feelsLike = try mainContainer.decodeIfPresent(Double.self, forKey: .feelsLike)
        let windContainer = try container.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        windSpeed = try windContainer.decodeIfPresent(Double.self, forKey: .speed)
        windDeg = try windContainer.decodeIfPresent(Double.self, forKey: .deg)
        let sysContainer = try container.nestedContainer(keyedBy: SysKeys.self, forKey: .sys)
        if let sunriseEpoch = try sysContainer.decodeIfPresent(Int.self, forKey: .sunrise) {
            sunrise = Date(timeIntervalSince1970: TimeInterval(sunriseEpoch))
        } else {
            sunrise = nil
        }
        if let sunsetEpoch = try sysContainer.decodeIfPresent(Int.self, forKey: .sunset) {
            sunset = Date(timeIntervalSince1970: TimeInterval(sunsetEpoch))
        } else {
            sunset = nil
        }
        let timezoneSeconds = try container.decodeIfPresent(Int.self, forKey: .timezone)
        timezone = TimeZone(secondsFromGMT: timezoneSeconds ?? 0)!
    }
}

extension Weather {
    enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case main
        case wind
        case clouds
        case sys
        case timezone
    }

    enum CoordKeys: String, CodingKey {
        case lon
        case lat
    }

    private class InnerWeather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    enum MainKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }

    enum WindKeys: String, CodingKey {
        case speed
        case deg
    }

    enum SysKeys: String, CodingKey {
        case sunrise
        case sunset
    }
}
