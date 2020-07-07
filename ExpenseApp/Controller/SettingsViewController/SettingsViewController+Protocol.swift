//
//  SettingsViewController+Protocol.swift
//  ExpenseApp
//
//  Created by IT Support on 5/24/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

extension SettingsViewController: AuthViewControllerDelegate, TextInputViewControllerDelegate {

    func textInputViewController(_ controller: TextInputViewController, primaryButtonClicked message: String, tag: Int) {
        switch tag {
        case 1:
            sendFeedback(feedback: message)
        default: break
        }
    }

    func textInputViewController(_ controller: TextInputViewController, secondaryButtonClicked message: String, tag: Int) {

    }

    func sendFeedback(feedback: String) {
        CoreDataManager.shared.getCurrentUser { (coreUser, error) in
            if error.code >= 300 {
                self.presentAlert(title: "Error", message: error.localizedDescription)
            }
            if let coreUser = coreUser, let username = coreUser.username {
                DBManager.shared.provideFeedback(username: username, feedback: feedback)
            }
            self.dismiss(animated: true, completion: nil)
        }
        UIView.animate(withDuration: 5.25, animations: {
            self.progressIndicator.show()
        }) { (true) in
            self.dismiss(animated: true, completion: nil)
        }
    }

    func authViewController(_ authViewController: AuthViewController, loggedIn model: SessionModel) {
        authViewController.dismiss(animated: true, completion: nil)
    }

    func checkUserSesssion() {
        let (currentUser, userError) = CoreDataManager.shared.getCurrentUser()

        if let userErr = userError {
            presentAlert(title: "Error", message: userErr.localizedDescription)
            return
        }

        guard let _ = currentUser else {
            let authViewController = AuthViewController()
            authViewController.delegate = self
            present(NavigationController(rootViewController: authViewController), animated: true, completion: nil)
            return
        }
    }
}
