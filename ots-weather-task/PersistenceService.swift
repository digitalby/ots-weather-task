//
//  PersistenceService.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import Foundation

class PersistenceService {
    let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    convenience init() {
        self.init(userDefaults: UserDefaults.standard)
    }

    func saveWeatherData(_ data: Data) {
        userDefaults.setValue(data, forKey: "weather")
    }

    func loadWeatherData() -> Data? {
        userDefaults.value(forKey: "weather") as? Data
    }
}
