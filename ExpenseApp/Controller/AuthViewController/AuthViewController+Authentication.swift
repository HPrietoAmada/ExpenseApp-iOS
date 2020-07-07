//
//  LoginSignupController+animations.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/8/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension AuthViewController {

    /* Member Field Validation methods */
    func isValidEmail(email: String) -> Bool {
        return email.underestimatedCount > 0
    }

    func isValidPassword(password: String) -> Bool {
        return self.regexValidation(password, regEx: "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()-_=+{}|?>.<,:;~`’]{6,}$")
    }

    /* Returns TRUE if field matches regEx */
    func regexValidation(_ field: String, regEx: String) -> Bool {
        var returnValue = true
        do {
            let regex = try NSRegularExpression(pattern: regEx)
            let nsString = field as NSString
            let results = regex.matches(in: field, range: NSRange(location: 0, length: nsString.length))
            if results.count == 0 {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }

    /* Returns TRUE if both email and password fields are valid */
    func validLoginFields() -> Bool {
        guard let email = self.emailField.text,
            let _ = self.passwordField.text else {
                return false
        }
        if isValidEmail(email: email) {
            return true
        }
        return false
    }
}
