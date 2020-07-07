//
//  TabBarViewController+Protocol.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/17/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import Foundation
import UIKit

extension TabBarController: AuthViewControllerDelegate, TripTableViewControllerDelegate {
    func tripTableViewController(_ controller: TripTableViewController, fetchData tag: Int) {
        fetchData()
    }

    func authViewController(_ authViewController: AuthViewController, loggedIn model: SessionModel) {
        fetchData()
    }
}
