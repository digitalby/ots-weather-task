//
//  ViewController.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private(set) lazy var client = WeatherClient()
    private(set) lazy var locationManager = LocationManager(
        onUpdate: { [weak self] location in
            print(location)
            let coordinate = Coordinate(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
            self?.client.getWeather(
                at: coordinate,
                completion: { weather, error in
                    print("completion: \(weather), \(error)")
            })
        }, onError: { error in
            print("Location failed with error \(error).")
    })

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestWhenInUseAuthorization()
    }
}
