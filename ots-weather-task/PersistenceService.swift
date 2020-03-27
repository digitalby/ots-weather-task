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
    private let weatherKey = "weather"
    private let mainTableViewContentOffsetKey = "mainTableViewContentOffset"

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    convenience init() {
        self.init(userDefaults: UserDefaults.standard)
    }

    func saveWeatherData(_ data: Data) {
        userDefaults.setValue(data, forKey: weatherKey)
    }

    func loadWeatherData() -> Data? {
        userDefaults.value(forKey: weatherKey) as? Data
    }

    func saveContentOffset(contentOffset: Double) {
        userDefaults.setValue(contentOffset, forKey: mainTableViewContentOffsetKey)
    }

    func loadContentOffset() -> Double? {
        userDefaults.value(forKey: mainTableViewContentOffsetKey) as? Double
    }
}
