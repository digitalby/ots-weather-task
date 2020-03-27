//
//  String+UnwrapInt.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import Foundation

extension String {
    init(_ int: Int?) {
        if let int = int {
            self = "\(int)"
        } else {
            self = "--"
        }
    }
}
