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

    private(set) lazy var tableViewHandler = TableViewHandler(viewModel: .unknown, onScroll: stateHelper.saveScrollContentOffset)

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
        onUpdate: onWeatherUpdate,
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
    func onWeatherUpdate(_ weather: Weather) {
        print("weather: \(weather)")
        let coordinate = Coordinate(
            latitude: weather.latitude,
            longitude: weather.longitude
        )
        let geocoder = GeocoderService()
        geocoder.geocodeCity(location: coordinate.clLocation) { [weak self] city, error in
            if let error = error {
                print("geocoder error \(error)")
            }
            DispatchQueue.main.async {
                let viewModel = WeatherViewModel(weather: weather, city: city)

                guard let self = self else { return }
                self.tableViewHandler.viewModel = viewModel
                self.updateMainView(with: viewModel)
                self.mainTableView.reloadData()
            }
        }
    }

    func updateMainView(with viewModel: WeatherViewModel) {
        locationLabel.text = viewModel.city
        temperatureLabel.text = viewModel.temperature
        weatherDescriptionLabel.text = viewModel.description
    }
}
