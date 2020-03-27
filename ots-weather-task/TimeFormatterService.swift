//
//  TimeFormatterService.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import UIKit

class TimeFormatterService {
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()

    func makeFormattedTime(for date: Date, timezone: TimeZone) -> String {
        formatter.timeZone = timezone
        return formatter.string(from: date)
    }
}
