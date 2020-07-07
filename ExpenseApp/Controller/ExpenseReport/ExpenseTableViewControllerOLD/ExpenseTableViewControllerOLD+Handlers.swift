//
//  ExpenseController+Handlers.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/12/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension ExpenseTableViewControllerOLD {

    /* User wants to go back to expenses report */
    @objc func handleLeftNavbarButton() {

    }

    /* User wants to add a new Mileage Expense */
    @objc func handleCreateTrip() {
        let navigationController = NavigationController(rootViewController: EXP_HDRViewController())
        self.present(navigationController, animated: true, completion: nil)
    }

    /* User wants to submit mileage reports to management */
    @objc func handleReportsSubmit() {
        self.lowerPowerModeCheck()
    }
}
