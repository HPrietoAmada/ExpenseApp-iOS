//
//  ModalInputView+Animations.swift
//  AmadaTimeOff
//
//  Created by IT Support on 6/20/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension ModalInputView {

    /**
     * handleError()
     * Changes the border color of the textfield
     * indicating an error occurred
     */
    func handleError(errorMessage: String) {
        self.titleLabel.text = errorMessage
        self.titleLabel.textColor = UIColor.red

        self.textField.becomeFirstResponder()
        self.textField.layer.borderColor = UIColor.red.cgColor
        self.textField.layer.borderWidth = 1
    }

    /**
     * handleErrorDismiss()
     * Changes the border color of the textfield
     * back to normal, indicating an error was handled
     */
    func handleErrorDismiss(title: String) {
        self.titleLabel.text = title
        self.titleLabel.textColor = UIColor.black
        
        self.textField.layer.borderColor = UIColor.clear.cgColor
        self.textField.layer.borderWidth = 0
    }
}
