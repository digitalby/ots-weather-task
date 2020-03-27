//
//  ViewController.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var weatherDescriptionLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var mainInfoView: UIView!
    @IBOutlet var mainTableView: UITableView!

    private(set) lazy var locationManager = LocationManager(
        onUpdate: { [weak self] location in
            print(location)
            let coordinate = Coordinate(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
            self?.weatherManager.updateWeatherData(at: coordinate)
        }, onError: { error in
            print("location error \(error)")
    })
    

    private(set) lazy var weatherManager = WeatherManager(
        onUpdate: { weather in
            print("weather: \(weather)")
            let coordinate = Coordinate(
                latitude: weather.latitude,
                longitude: weather.longitude
            )
            let geocoder = GeocoderService()
            geocoder.geocodeCity(location: coordinate.clLocation) { city, error in
                if let error = error {
                    print("geocoder error \(error)")
                } else if let city = city {
                    print("the city is \(city)")
                }
            }
    }, onError: { error in
            print("weather error \(error)")
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
    }
}
