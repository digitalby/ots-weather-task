//
//  WeatherService.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import Foundation

class WeatherManager {
    let client = WeatherClient()
    let parser = WeatherParser()
    let persistenceService = PersistenceService()

    private let onUpdate: (Weather)->()
    private let onError: (Error)->()

    init(onUpdate: @escaping (Weather)->(), onError: @escaping (Error)->()) {
        self.onUpdate = onUpdate
        self.onError = onError
    }

    func updateWeatherData(at coordinate: Coordinate) {
        if let persistentData = persistenceService.loadWeatherData() {
            parseWeatherData(persistentData)
        } else {
            client.getWeatherData(
                at: coordinate,
                completion: { [weak self] data, error in
                    if let error = error {
                        self?.onError(error)
                    } else if let data = data {
                        self?.parseWeatherData(data)
                    }
            })
        }
    }

    private func parseWeatherData(_ data: Data) {
        do {
            let weather = try parser.parseWeather(from: data)
            persistenceService.saveWeatherData(data)
            onUpdate(weather)
        } catch {
            print(error)
            onError(error)
        }
    }
}
