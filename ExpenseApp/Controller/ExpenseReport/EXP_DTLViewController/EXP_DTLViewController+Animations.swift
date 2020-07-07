//
//  CreateExpenseController+Animations.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/12/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension EXP_DTLViewController {

    func enableSubmitMileageExpenseReportButton() {
        createExpenseButton.backgroundColor = UIColor.MainColors.lightColor
        createExpenseButton.isEnabled = true
    }

    func disableSubmitMileageExpenseReportButton() {
        createExpenseButton.backgroundColor = UIColor.MainColors.lightGray
        createExpenseButton.isEnabled = false
    }

    func displayMileageExpenseView(_ display: Bool = true) {
        odoFromViewNumberPad.display(display)
        odoToViewNumberPad.display(display)
    }
}
