//
//  WeatherViewModel.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import Foundation

struct WeatherViewModel {
    let city: String
    let description: String
    let temperature: String
    let info: [WeatherInfoViewModel]
}

extension WeatherViewModel {
    init(city: String?, description: String?, temperature: Int?, info: [WeatherInfoViewModel] = []) {
        self.city = city ?? "Unknown Location"
        self.temperature = "\(String(temperature))°"
        self.description = description ?? "?"
        self.info = info
    }

    init(weather: Weather, city: String?) {
        var info = [WeatherInfoViewModel]()
        info.append(contentsOf: [
            WeatherInfoViewModel(title: "Min Temperature", value: "\(String(weather.temperatureMin?.roundInt))°"),
            WeatherInfoViewModel(title: "Max Temperature", value: "\(String(weather.temperatureMax?.roundInt))°"),
            WeatherInfoViewModel(title: "Feels Like", value: "\(String(weather.feelsLike?.roundInt))°"),
            WeatherInfoViewModel(title: "Wind", value: "\(String(weather.windSpeed?.roundInt)) m/s \(weather.windDeg?.compassPoint ?? "")"),
            WeatherInfoViewModel(title: "Humidity", value: "\(String(weather.humidity?.roundInt))%")
        ])
        if let pressure = weather.pressure {
            let pressureMmHg = pressure * 100 / 133
            info.append(WeatherInfoViewModel(title: "Pressure", value: "\(pressureMmHg.roundInt) mm Hg"))
        } else {
            info.append(WeatherInfoViewModel(title: "Pressure", value: "?"))
        }
        var sunriseString = "?"
        var sunsetString = "?"
        if let timezone = weather.timezone {
            let formatter = TimeFormatterService()
            if let sunrise = weather.sunrise {
                sunriseString = formatter.makeFormattedTime(for: sunrise, timezone: timezone)
            }
            if let sunset = weather.sunset {
                sunsetString = formatter.makeFormattedTime(for: sunset, timezone: timezone)
            }
        }
        info.append(WeatherInfoViewModel(title: "Sunrise", value: sunriseString))
        info.append(WeatherInfoViewModel(title: "Sunset", value: sunsetString))
        self.init(city: city, description: weather.description, temperature: weather.temperature?.roundInt, info: info)
    }
}

extension WeatherViewModel {
    static var unknown: Self {
        WeatherViewModel(city: nil, description: nil, temperature: nil, info: [])
    }
}
