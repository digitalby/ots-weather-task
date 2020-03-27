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

    let decoder = JSONDecoder()

    private var baseURL: URL {
        URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=\(Secret.apiKey)&units=metric")!
    }

    func getWeather(at coordinate: Coordinate, completion: @escaping (Weather?, Error?)->()) {
        guard let url = URL(
            string: "\(baseURL.absoluteString)&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
            ) else {
                completion(nil, WeatherError.invalidURL)
                return
        }
        let request = URLRequest(url: url)

        let task = downloader.makeJSONTask(with: request) { [weak self] data, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                } else if let data = data {
                    do {
                        let weather = try self?.decoder.decode(Weather.self, from: data)
                        completion(weather, nil)
                    } catch {
                        print(error)
                        completion(nil, WeatherError.parsingFailed)
                    }
                }
            }
        }
        task.resume()
    }
}

//MARK: - Helpers
private extension WeatherClient {

}
