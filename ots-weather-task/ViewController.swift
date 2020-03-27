//
//  ViewController.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController {

    let locationManager = LocationManager(
        onUpdate: { location in
            print(location)
    }, onError: { error in
        print("Location failed with error \(error).")
    })

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestWhenInUseAuthorization()
    }
}
