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

    func makeJSONTask(with request: URLRequest, completion: @escaping ([String: AnyObject]?, Error?)->()) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, WeatherError.requestFailed)
                return
            }

            if response.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                        completion(json, nil)
                    } catch {
                        completion(nil, WeatherError.parsingFailed)
                    }
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
