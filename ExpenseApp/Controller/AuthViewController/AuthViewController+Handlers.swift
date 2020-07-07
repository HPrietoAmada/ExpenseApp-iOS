//
//  LoginSignupController+handlers.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/8/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension AuthViewController {
    
    /* Enables login button if fields are correct */
    @objc func handleEmailField() {
        if self.validLoginFields() {
            self.enableLoginButton()
        } else {
            self.disableLoginButton()
        }
    }
    
    /* Enables login button if fields are correct */
    @objc func handlePasswordField() {
        if self.validLoginFields() {
            self.enableLoginButton()
        } else {
            self.disableLoginButton()
        }
    }
    
    /* Logs user and sends to ProfileController */
    @objc func handleLogin() {
        if ProcessInfo.processInfo.isLowPowerModeEnabled {
            self.batteryModeAlert()
            return
        }

        progressIndicator.show()

        guard let email = emailField.text,
            let password = passwordField.text else {
                progressIndicator.hide()
                return
        }
        DBManager.shared.login(email: email, password: password) { (sessionModel, error) in
            if error.code >= 300 {
                self.presentAlert(title: "Error", message: error.localizedDescription)
                self.progressIndicator.hide()
                return
            }
            guard let sessionModel = sessionModel else {
                self.progressIndicator.hide()
                return
            }
            CoreDataManager.shared.saveUserSession(sessionModel: sessionModel) { (err) in
                if err.code >= 300 {
                    self.presentAlert(title: "Error", message: err.localizedDescription)
                    self.progressIndicator.hide()
                    return
                }

                if let delegate = self.delegate {
                    self.dismiss(animated: true, completion: {
                        self.progressIndicator.hide()
                    })
                    delegate.authViewController(self, loggedIn: sessionModel)
                }
            }
        }
    }
    
    /* Called on keyboard show in view */
    @objc func handleKeyboardWillShow(_ notification: Notification) {
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardHeight = keyboardFrame!.height
        self.loginButtonBottomConstraint?.constant = -(keyboardHeight + 20)
        self.loginScrollViewHeightConstraint?.constant = self.view.bounds.height - keyboardHeight
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    /* Called on keyboard hide in view */
    @objc func handleKeyboardWillHide(_ notification: Notification) {
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        self.loginButtonBottomConstraint?.constant = -20
        self.loginScrollViewHeightConstraint?.constant = self.view.bounds.height
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
