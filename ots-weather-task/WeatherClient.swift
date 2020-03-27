//
//  WeatherClient.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import Foundation

class WeatherClient {
    let downloader = JSONDownloader()

    private var baseURL: URL {
        URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=\(Secret.apiKey)&units=metric")!
    }

    func getWeatherData(at coordinate: Coordinate, completion: @escaping (Data?, Error?)->()) {
        guard let url = URL(
            string: "\(baseURL.absoluteString)&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
            ) else {
                completion(nil, WeatherError.invalidURL)
                return
        }
        let request = URLRequest(url: url)

        let task = downloader.makeJSONTask(with: request) { data, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                } else if let data = data {
                    completion(data, nil)
                }
            }
        }
        task.resume()
    }
}
