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
    var viewModel: WeatherViewModel

    init(viewModel: WeatherViewModel, onScroll: @escaping (CGPoint)->()) {
        self.viewModel = viewModel
        print(self.viewModel.info.count)
        self.onScroll = onScroll
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Updating: \(viewModel.info.count))")
        return viewModel.info.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInfoCell") else { fatalError() }
        let infoAtIndex = viewModel.info[indexPath.row]
        cell.textLabel?.text = infoAtIndex.title
        cell.detailTextLabel?.text = infoAtIndex.value
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
