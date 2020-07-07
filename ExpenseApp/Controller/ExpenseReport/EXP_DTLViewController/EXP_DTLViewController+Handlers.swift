//
//  CreateExpenseController+Handlers.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/12/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension EXP_DTLViewController {

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }

    /* User tapped on left navbar button */
    @objc func handleNavbarCancel() {
        dismiss(animated: true, completion: nil)
    }

    /* User wants to go back to Calender */
    @objc func handleDetailCancel() {
        dismiss(animated: true, completion: nil)
        view.endEditing(true)
    }

    @objc func handleUpdateExpense() {
        if lowPowerModeON() {
            self.batteryModeAlert()
            return
        }

        updateExpenseButton.isEnabled = false
        progressIndicator.text = "Updating Expense..."
        progressIndicator.show()
        createEXP_DTLFromFields { (model, message) in
            guard let model = model else {
                progressIndicator.hide()
                return
            }
            if let _ = _expense {
                DBManager.shared.updateExpense(model: model) { (error) in
                    if error.code >= 300 {
                        self.updateExpenseButton.isEnabled = true
                        self.progressIndicator.hide()
                        self.presentAlert(title: "Error", message: "\(error.localizedDescription) Make sure you're connected to Amada's VPN")
                        return
                    }
                    if let delegate = self._formSubmitDelegate {
                        delegate.viewController(self, formSubmitError: NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Success"]), tag: self.tag)
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
            updateExpenseButton.isEnabled = true
        }
    }

    /* User wants to submit form */
    @objc func handleCreateExpense() {
        // let images = self.attachReceiptsImagePickerView.images

        createExpenseButton.isEnabled = false

        if lowPowerModeON() {
            self.batteryModeAlert()
            return
        }

        progressIndicator.text = "Creating Expense..."
        progressIndicator.show()
        /*
        var expFiles: [EXP_FILES] = [EXP_FILES]()
        attachReceiptsImagePickerView.images.forEach { (image) in
            var expFile: EXP_FILES = EXP_FILES(image)
            expFile.title = "Testing image upload feature."
            expFiles.append(expFile)
        }

        DBManager.shared.uploadFiles(expFiles) { (error) in
            self.presentAlert(
                title: "Error",
                message: "Code \(error.code): \(error.localizedDescription)"
            )
        }*/


        createEXP_DTLFromFields { (model, message) in
            guard let expense = model else {
                progressIndicator.hide()
                return
            }
            createExpenseButton.isEnabled = true
            // User is creating an expense from trip stored in database
            if let _ = exp_hdr {
                // INSERT into WEB_VIA2.EXP_DTL
                let expenseModel = ExpenseModel()
                expenseModel.Expense = expense
                expenseModel.Guests = self._guestList
                DBManager.shared.createExpenseModel(expenseModel, { (error) in
                    self.progressIndicator.hide()
                    if error.code >= 300 {
                        self.presentAlert(title: "Error", message: "\(error.localizedDescription) Make sure you're connected to Amada's VPN")
                        // self.storeExpenseLocally(model: model)
                        return
                    }
                    if let delegate = self._formSubmitDelegate {
                        delegate.viewController(self, formSubmitError: NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Success"]), tag: self.tag)
                    }
                    let createExpenseAlert = UIAlertController(title: "Expense Created", message: "Would you like to create another?", preferredStyle: .alert)
                    createExpenseAlert.addAction(UIAlertAction(title: "Finish", style: .cancel, handler: { (alert) in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    createExpenseAlert.addAction(UIAlertAction(title: "Add Expense", style: .default, handler: { (alertAction) in
                        self.resetCreateExpenseController()
                    }))
                    self.present(createExpenseAlert, animated: true, completion: nil)
                })
            }
            /*
            if let _ = exp_hdr_core {
                self.storeExpenseLocally(model: model)
            }*/
        }
    }

    func storeExpenseLocally(model: EXP_DTL) {
        // Store locally until
        CoreDataManager.shared.createEXP_DTL(model: model, { (coreModel, error) in
            if let error = error {
                self.presentAlert(title: "Error", message: error.localizedDescription)
                return
            }
            self.resetCreateExpenseController()
        })
    }

    func resetCreateExpenseController() {
        createExpenseButton.isEnabled = true
        updateExpenseButton.isEnabled = true
        resetInputViews()
        scrollToTop()
        progressIndicator.hide()
    }

    /* Hides Keyboard Views */
    @objc func handleHideKeyboard() {
        guard let _ = getFirstResponder() else {
            return
        }
        view.endEditing(true)
    }

    /**
        - This method returns the view that is currently in focus(firstResponder)
     */
    func getFirstResponder() -> UIView? {
        switch true {
        case odoFromViewNumberPad.field.isFirstResponder:
            return odoFromViewNumberPad

        case odoToViewNumberPad.field.isFirstResponder:
            return odoToViewNumberPad

        case expenseTypePicker.field.isFirstResponder:
            return expenseTypePicker

        case totalAmountNumberPad.field.isFirstResponder:
            return totalAmountNumberPad

        case mealTypePicker.field.isFirstResponder:
            return mealTypePicker

        case tipsNumberPad.field.isFirstResponder:
            return tipsNumberPad

        case notesInputView.textView.isFirstResponder:
            return notesInputView
        default:
            return nil
        }
    }

    @objc func handleKeyboardWillShow(_ notification: Notification) {
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        let keyboardHeight = keyboardFrame!.height
        if let firstResponder = self.getFirstResponder() {
            guard let yPosition = firstResponder.globalPoint else {
                return
            }
            if yPosition.y < view.frame.height - keyboardHeight { return }
            let scrollViewY = (firstResponder.center.y) * (0.70)
            let point = CGPoint(x: 0, y: scrollViewY)
            scrollView.setContentOffset(point, animated: true)
        }
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }

    @objc func handleKeyboardWillHide(_ notification: Notification) {
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        UIView.animate(withDuration: keyboardDuration!,
                       animations: {
            self.view.layoutIfNeeded()
        })
    }

    /**
        - This method dismisses keybord while also scrolling
            the scrollView to it's proper place
     */
    @objc func handleDismissKeyboard() {
        view.endEditing(true)
    }

    @objc func handlePickerWillHide(_ notification: Notification) {

    }
}
