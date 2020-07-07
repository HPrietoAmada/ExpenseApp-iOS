//
//  TripTableViewController+Protocol.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/19/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

extension TripTableViewController: UIViewControllerFormSubmitDelegate {
    func viewController(_ viewController: UIViewController, formSubmitError error: NSError, tag: Int) {
        if tag == 1 {
            if let tabController = self.tabBarController as? TabBarController {
                tabController.fetchData()
            }
        }
    }
}
