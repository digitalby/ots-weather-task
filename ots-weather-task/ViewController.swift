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

    let stateHelper = ViewControllerStateHelper()

    private(set) lazy var tableViewHandler = TableViewHandler(onScroll: stateHelper.saveScrollContentOffset)

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
        onUpdate: configureWithWeather,
        onError: { error in
            print("weather error \(error)")
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = tableViewHandler
        mainTableView.delegate = tableViewHandler
        locationManager.requestWhenInUseAuthorization()
        weatherManager.loadPersistentWeatherData()
        stateHelper.updateScrollContentOffsetFromPersistent(for: mainTableView)
    }
}

//MARK: - Configuration
extension ViewController {
    func configureWithWeather(_ weather: Weather) {
        print("weather: \(weather)")
        let coordinate = Coordinate(
            latitude: weather.latitude,
            longitude: weather.longitude
        )
        let geocoder = GeocoderService()
        geocoder.geocodeCity(location: coordinate.clLocation) { [weak self] city, error in
            if let error = error {
                print("geocoder error \(error)")
            } else if let city = city {
                self?.locationLabel.text = city
            }
        }

        let formatter = TimeFormatterService()

        temperatureLabel.text = "\(weather.temperature.roundInt)°"
        weatherDescriptionLabel.text = weather.description
        var titles = [String]()
        var values = [String]()
        titles.append("Min Temperature")
        values.append("\(weather.temperatureMin.roundInt)°")
        titles.append("Max Temperature")
        values.append("\(weather.temperatureMax.roundInt)°")
        titles.append("Humidity")
        values.append("\(weather.humidity.roundInt)%")
        titles.append("Wind")
        values.append("\(weather.windSpeed.roundInt) m/s \(weather.windDeg.compassPoint ?? "")")
        titles.append("Feels Like")
        values.append("\(weather.feelsLike.roundInt)°")
        titles.append("Pressure")
        let pressureMmHg = weather.pressure * 100 / 133
        values.append("\(pressureMmHg.roundInt) mm Hg")
        titles.append("Sunrise")
        values.append("\(formatter.makeFormattedTime(for: weather.sunrise, timezone: weather.timezone))")
        titles.append("Sunset")
        values.append("\(formatter.makeFormattedTime(for: weather.sunset, timezone: weather.timezone))")
        reloadTableViewWith(titles: titles, values: values)
    }

    func reloadTableViewWith(titles: [String], values: [String]) {
        tableViewHandler.titles = titles
        tableViewHandler.values = values
        mainTableView.reloadData()
    }
}
