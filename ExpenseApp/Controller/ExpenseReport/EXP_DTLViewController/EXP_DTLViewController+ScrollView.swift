//
//  CreateExpenseController+ScrollView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/12/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension EXP_DTLViewController: UIScrollViewDelegate, UITextFieldDelegate {

    // MARK : Add all views to scrollView

    /* Initializes DetailView's Components */
    func initializeDetailPickers() {
        // Set Component Designs
        let viewWidth = view.bounds.width - 50

        // Mileage ScrollView Constraints
        scrollView.delegate = self
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 500)
        
        // Add Pickers to scrollView
        scrollView.addSubview(titleView)
        scrollView.addSubview(expenseTypePicker)
        scrollView.addSubview(expBegDateTimePickerView)
        scrollView.addSubview(expEndDateTimePickerView)
        scrollView.addSubview(odoUOMPicker)
        scrollView.addSubview(odoFromViewNumberPad)
        scrollView.addSubview(odoToViewNumberPad)
        scrollView.addSubview(perDiemCheckboxView)
        scrollView.addSubview(mealTypePicker)
        scrollView.addSubview(mealLocationPicker)
        scrollView.addSubview(mealAllowancePicker)
        scrollView.addSubview(mealMiscTypePicker)
        scrollView.addSubview(mealMiscLocationPicker)
        scrollView.addSubview(currencyTypePicker)
        scrollView.addSubview(totalAmountNumberPad)
        scrollView.addSubview(tipsNumberPad)
        scrollView.addSubview(guestSelectView)
        scrollView.addSubview(notesInputView)
        scrollView.addSubview(endLatLonLocationSelectView)
        scrollView.addSubview(begLatLonSelectView)
        scrollView.addSubview(roundTripCheckboxView)
        scrollView.addSubview(attachReceiptsImagePickerView)

        // Mileage Expense Title View
        titleView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        titleView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        titleView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        expenseTypePicker.delegate = self
        expenseTypePicker.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10).isActive = true
        expenseTypePicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        expenseTypePicker.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        
        expBegDateTimePickerView.topAnchor.constraint(equalTo: expenseTypePicker.bottomAnchor).isActive = true
        expBegDateTimePickerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        expBegDateTimePickerView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        expBegDateTimePickerView.delegate = self
        expBegDateTimePickerView.toolBarDone.action = #selector(handleDismissKeyboard)

        expEndDateTimePickerView.topAnchor.constraint(equalTo: expBegDateTimePickerView.bottomAnchor).isActive = true
        expEndDateTimePickerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        expEndDateTimePickerView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        expEndDateTimePickerView.delegate = self
        expEndDateTimePickerView.toolBarDone.action = #selector(handleDismissKeyboard)

        // Origin Button
        begLatLonSelectView.delegate = self
        begLatLonSelectView.topAnchor.constraint(equalTo: expEndDateTimePickerView.bottomAnchor).isActive = true
        begLatLonSelectView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        begLatLonSelectView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        // Destination Button
        endLatLonLocationSelectView.delegate = self
        endLatLonLocationSelectView.topAnchor.constraint(equalTo: begLatLonSelectView.bottomAnchor, constant: 10).isActive = true
        endLatLonLocationSelectView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        endLatLonLocationSelectView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        odoUOMPicker.topAnchor.constraint(equalTo: endLatLonLocationSelectView.bottomAnchor).isActive = true
        odoUOMPicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        odoUOMPicker.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true

        // Odometer Start Field Constraints
        // odomStartViewNumberPad.field.delegate = self
        odoFromViewNumberPad.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        odoFromViewNumberPad.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        odoFromViewNumberPad.topAnchor.constraint(equalTo: odoUOMPicker.bottomAnchor, constant: 0).isActive = true
        odoFromViewNumberPad.delegate = self

        // Odometer End Field Constraints
        // odomEndViewNumberPad.field.delegate = self
        odoToViewNumberPad.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        odoToViewNumberPad.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        odoToViewNumberPad.topAnchor.constraint(equalTo: odoFromViewNumberPad.bottomAnchor, constant: 0).isActive = true
        odoToViewNumberPad.delegate = self

        roundTripCheckboxView.delegate = self
        roundTripCheckboxView.topAnchor.constraint(equalTo: odoToViewNumberPad.bottomAnchor).isActive = true
        roundTripCheckboxView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        roundTripCheckboxView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        perDiemCheckboxView.delegate = self
        perDiemCheckboxView.topAnchor.constraint(equalTo: roundTripCheckboxView.bottomAnchor).isActive = true
        perDiemCheckboxView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        perDiemCheckboxView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        //mealTypePicker.delegate = self
        mealTypePicker.topAnchor.constraint(equalTo: perDiemCheckboxView.bottomAnchor).isActive = true
        mealTypePicker.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        mealTypePicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        //mealLocationPicker.delegate = self
        mealLocationPicker.topAnchor.constraint(equalTo: mealTypePicker.bottomAnchor).isActive = true
        mealLocationPicker.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        mealLocationPicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        mealAllowancePicker.delegate = self
        mealAllowancePicker.topAnchor.constraint(equalTo: mealLocationPicker.bottomAnchor).isActive = true
        mealAllowancePicker.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        mealAllowancePicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        mealMiscTypePicker.delegate = self
        mealMiscTypePicker.topAnchor.constraint(equalTo: mealAllowancePicker.bottomAnchor).isActive = true
        mealMiscTypePicker.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        mealMiscTypePicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        mealMiscLocationPicker.delegate = self
        mealMiscLocationPicker.topAnchor.constraint(equalTo: mealMiscTypePicker.bottomAnchor).isActive = true
        mealMiscLocationPicker.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        mealMiscLocationPicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        currencyTypePicker.topAnchor.constraint(equalTo: mealMiscLocationPicker.bottomAnchor).isActive = true
        currencyTypePicker.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        currencyTypePicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        totalAmountNumberPad.field.delegate = self
        totalAmountNumberPad.topAnchor.constraint(equalTo: currencyTypePicker.bottomAnchor, constant: 0).isActive = true
        totalAmountNumberPad.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        totalAmountNumberPad.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        tipsNumberPad.field.delegate = self
        tipsNumberPad.topAnchor.constraint(equalTo: totalAmountNumberPad.bottomAnchor).isActive = true
        tipsNumberPad.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        tipsNumberPad.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        guestSelectView.delegate = self
        guestSelectView.topAnchor.constraint(equalTo: tipsNumberPad.bottomAnchor).isActive = true
        guestSelectView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        guestSelectView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        notesInputView.topAnchor.constraint(equalTo: guestSelectView.bottomAnchor).isActive = true
        notesInputView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        notesInputView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        attachReceiptsImagePickerView.delegate = self
        attachReceiptsImagePickerView.topAnchor.constraint(equalTo: notesInputView.bottomAnchor).isActive = true
        attachReceiptsImagePickerView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        attachReceiptsImagePickerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        // Check if updating or creating new expense
        if canUpdate {
            let updatingExpense: Bool = _expense != nil
            if updatingExpense {
                scrollView.addSubview(updateExpenseButton)
                updateExpenseButton.topAnchor.constraint(equalTo: attachReceiptsImagePickerView.bottomAnchor, constant: 10).isActive = true
                updateExpenseButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
                updateExpenseButton.width = viewWidth

                expenseTypePicker.isMultipleTouchEnabled = false
                expenseTypePicker.isUserInteractionEnabled = false
            } else {
                scrollView.addSubview(createExpenseButton)

                // Mileage Form Submit Button Constraints
                createExpenseButton.topAnchor.constraint(equalTo: attachReceiptsImagePickerView.bottomAnchor, constant: 10).isActive = true
                createExpenseButton.widthAnchor.constraint(equalToConstant: view.bounds.width - 50).isActive = true
                createExpenseButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
                createExpenseButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            }
        }

        // Initially Hide All Views
        noExpense(false)
    }

    // MARK : ScrollView functions

    /* User began dragging ScrollView */
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        animateDetailTopBorder(scrollView)

        if let _ = getFirstResponder() {
            handleDismissKeyboard()
        }
    }

    /* User stopped dragging ScrollView */
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        animateDetailTopBorder(scrollView)
    }

    /* ScrollView stopped scrolling */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        animateDetailTopBorder(scrollView)
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        animateDetailTopBorder(scrollView)
    }

    /*
     Expense Report Detail Border animations
     */
    func animateDetailTopBorder(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y
        showDetailTopBorder(scrollOffset <= 0 ? false : true)
    }

    /* Animates the disappearance of Detail View's top border */
    func showDetailTopBorder(_ show: Bool = true) {
        topBorder.backgroundColor = show ? UIColor.lightGray : UIColor.clear
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}
