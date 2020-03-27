//
//  JSONDownloader.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import Foundation

class JSONDownloader {
    let session: URLSession

    init(config: URLSessionConfiguration) {
        session = URLSession(configuration: config)
    }

    convenience init() {
        self.init(config: .default)
    }

    func makeJSONTask(with request: URLRequest, completion: @escaping (Data?, Error?)->()) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, WeatherError.requestFailed)
                return
            }

            if response.statusCode == 200 {
                if let data = data {
                    completion(data, nil)
                } else {
                    completion(nil, WeatherError.badDataRetrieved)
                }
            } else {
                completion(nil, WeatherError.badStatusCode(response.statusCode))
            }
        }
        return task
    }
}
