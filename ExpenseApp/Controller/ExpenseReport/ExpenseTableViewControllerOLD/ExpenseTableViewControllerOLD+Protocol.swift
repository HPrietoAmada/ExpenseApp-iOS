//
//  ExpenseController+Protocol.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/24/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension ExpenseTableViewControllerOLD: AuthViewControllerDelegate {

    func displayMessageView(message: String) {
        messageView.text = message
        messageView.alpha = 1
    }

    func hideMessageView() {
        messageView.text = ""
        messageView.alpha = 0
    }

    func authViewController(_ authViewController: AuthViewController, loggedIn model: SessionModel) {
        print("Logged in: \(model)")
    }
}
