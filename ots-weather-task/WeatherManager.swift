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

    func loadPersistentWeatherData() {
        if let persistentData = persistenceService.loadWeatherData() {
            parseWeatherData(persistentData)
        }
    }

    private func parseWeatherData(_ data: Data) {
        do {
            let weather = try self.parser.parseWeather(from: data)
            self.persistenceService.saveWeatherData(data)
            self.onUpdate(weather)
        } catch {
            self.onError(error)
        }
    }
}
