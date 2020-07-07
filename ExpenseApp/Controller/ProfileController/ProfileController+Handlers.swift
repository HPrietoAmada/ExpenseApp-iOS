//
//  ProfileController+handlers.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/9/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension ProfileController {
    
    /* Directs user to AbsenceReportController upon clicking */
    @objc func handlePreApprovedMeetingButtonClick() {
        let absenceReportController = TabBarController()
        self.navigationController?.pushViewController(absenceReportController, animated: true)
    }
    
    /* Directs user to ExpenseReportController upon clicking */
    @objc func handleWeeklyExpenseReportButtonClick() {
        let expenseReportController = TabBarController()
        self.navigationController?.pushViewController(expenseReportController, animated: true)
    }
}
