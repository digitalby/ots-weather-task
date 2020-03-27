//
//  ViewControllerStateHelper.swift
//  ots-weather-task
//
//  Created by Digital on 27/03/2020.
//  Copyright © 2020 digitalby. All rights reserved.
//

import UIKit

class ViewControllerStateHelper {
    let service = PersistenceService()

    func saveScrollContentOffset(_ contentOffset: CGPoint) {
        service.saveContentOffset(contentOffset: Double(contentOffset.y))
    }

    func updateScrollContentOffsetFromPersistent(for scrollView: UIScrollView)  {
        let offset = service.loadContentOffset() ?? 0.0
        scrollView.setContentOffset(CGPoint(x: 0.0, y: offset), animated: false)
    }
}
