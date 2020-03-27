//
//  TableViewHandler.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import UIKit

class TableViewHandler: NSObject, UITableViewDataSource, UITableViewDelegate {

    let onScroll: (CGPoint)->()

    init(onScroll: @escaping (CGPoint)->()) {
        self.onScroll = onScroll
    }

    var titles = [String]()
    var values = [String]()

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        values.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInfoCell") else { fatalError() }
        cell.textLabel?.text = titles[indexPath.row]
        cell.detailTextLabel?.text = values[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onScroll(scrollView.contentOffset)
    }
}
