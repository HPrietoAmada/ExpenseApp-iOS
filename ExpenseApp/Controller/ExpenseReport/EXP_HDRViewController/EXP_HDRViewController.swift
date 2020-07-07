//
//  TripCreateViewController.swift
//  AmadaTimeOff
//
//  Created by IT Support on 11/6/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

/*

 struct EXP_HDR: Codable {
     public var ID: Int?
     public var CO_CODE: String?
     public var USER_ID: Int?
     public var EMP_ID: Int?
     public var EMP_VENDOR_NUM: String?
     public var BEG_DATE: String?
     public var END_DATE: String?
     public var EXP_STATUS: String?
     public var TRIP_TYPE: String?
     public var TRIP_NAME: String?
     public var PURPOSE: String?
     public var CASH_ON_HAND: Double?
     public var CASH_ADVANCED: Double?
     public var PR_ID: Int?
     public var AWA_NUMBER: String?
     public var COST_CENTER: String?
     public var GL_ACCOUNT: String?
     public var PROFIT_CENTER: String?
     public var REQUESTED_DATE: String?
     public var REQUESTED_BY: String?
     public var SUBMITTED_DATE: String?
     public var SUBMITTED_BY: String?
     public var APPROVED_DATE: String?
     public var APPROVED_BY: String?
     public var REJECT_REASON: String?
     public var REJECTED_DATE: String?
     public var REJECTED_BY: String?
     public var CREATED_DATE: String?
     public var CREATED_BY: String?
     public var CHANGED_DATE: String?
     public var CHANGED_BY: String?
     public var NOTES: String?
 }

*/

protocol UIViewControllerFormSubmitDelegate {
    func viewController(_ viewController: UIViewController, formSubmitError error: NSError, tag: Int)
}

class EXP_HDRViewController: UIViewController {

    var _formSubmitDelegate: UIViewControllerFormSubmitDelegate?

    var tag: Int = 0

    var _canUpdate: Bool = true {
        didSet {
            scrollView.subviews.forEach { subview in
                subview.isUserInteractionEnabled = _canUpdate
                subview.isMultipleTouchEnabled = _canUpdate
            }
        }
    }

    var trip: EXP_HDR? {
        didSet {
            guard let exp_hdr = trip else {
                return
            }

            if let tripName = exp_hdr.TRIP_NAME {
                tripNameInputView.text = tripName
            }

            CoreDataManager.shared.getAAI_TABLE_COLUMN_REF { (models, error) in
                guard let models = models else {
                    self.presentAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                let tripTypes = models.filter { $0.COLUMN_NAME == "TRIP_TYPE" }
                if let tripTableColumnRef = tripTypes.first(where: { $0.COLUMN_VALUE == exp_hdr.TRIP_TYPE }) {
                    self.tripTypePickerView._value = tripTableColumnRef
                }
            }

            if let beg_date_str = exp_hdr.BEG_DATE,
                let beg_date = beg_date_str.toDateTime() {
                tripStartTimeView.date = beg_date
            }

            if let end_date_str = exp_hdr.END_DATE,
                let end_date = end_date_str.toDateTime() {
                tripEndTimeView.date = end_date
            }

            if let cash_on_hand = exp_hdr.CASH_ON_HAND {
                cashOnHandTextView.text = "\(cash_on_hand)"
            }

            if let cash_advanced = exp_hdr.CASH_ADVANCED {
                cashAdvancedHandTextView.text = "\(cash_advanced)"
            }

            if let purpose = exp_hdr.PURPOSE {
                purposeTextInputView.text = purpose
            }
            /*
            if let awa = exp_hdr.AWA_NUMBER {
                //labeledAWASearchView.text = awa
            }*/

            if let notes = exp_hdr.NOTES {
                notesTextInputView._description = notes
            }
        }
    }

    var expenseList: [EXP_DTL]?

    lazy var closeNavbarButtonItem: CloseNavbarButtonItem = {
        let closeNavbarButtonItem = CloseNavbarButtonItem()
        closeNavbarButtonItem.action = #selector(goBack)
        closeNavbarButtonItem.target = self
        return closeNavbarButtonItem
    }()

    lazy var addExpenseNavbarButtonItem: TextNavbarButtonItem = {
        let textNavbarButtonItem = TextNavbarButtonItem("Add Expense")
        textNavbarButtonItem.target = self
        // textNavbarButtonItem.action = #selector(addExpense)
        return textNavbarButtonItem
    }()

    let scrollView: ScrollView = {
        let scrollView = ScrollView()
        return scrollView
    }()

    let titleView: TitleView = {
        let titleView = TitleView(
            "Trip",
            subtitle: "Trip Name and Date Range are required fields"
        )
        return titleView
    }()

    let tripTypePickerView: LabeledTableColumnRefPickerView = {
        let pickerView = LabeledTableColumnRefPickerView(
            "Trip Types",
            placeholder: "Select a Trip Type"
        )
        return pickerView
    }()

    let tripNameInputView: LabeledTextField = {
        let labeledTextField = LabeledTextField(
            "Trip Name",
            tag: 1,
            placeholder: "Enter the name of the trip being created"
        )
        return labeledTextField
    }()

    let tripStartTimeView: LabeledTimePickerView = {
        let labeledDatePickerView = LabeledTimePickerView(
            "Start Time",
            tag: 1,
            placeholder: "Enter the time your trip started"
        )
        labeledDatePickerView.datePicker.datePickerMode = .dateAndTime
        labeledDatePickerView.dateFormat = "MMM d, yyyy h:mm a"
        return labeledDatePickerView
    }()

    let tripEndTimeView: LabeledTimePickerView = {
        let labeledDatePickerView = LabeledTimePickerView(
            "End Time",
            tag: 2,
            placeholder: "Enter the time your trip ended"
        )
        labeledDatePickerView.datePicker.datePickerMode = .dateAndTime
        labeledDatePickerView.dateFormat = "MMM d, yyyy h:mm a"
        return labeledDatePickerView
    }()

    let cashOnHandTextView: LabeledTextField = {
        let labeledTextField = LabeledTextField(
            "Cash on Hand",
            tag: 2,
            placeholder: "Enter your total cash on hand"
        )
        labeledTextField.field.keyboardType = .decimalPad
        return labeledTextField
    }()

    let cashAdvancedHandTextView: LabeledTextField = {
        let labeledTextField = LabeledTextField(
            "Cash Advanced",
            tag: 3,
            placeholder: "Enter the total cash advanced"
        )
        labeledTextField.field.keyboardType = .decimalPad
        return labeledTextField
    }()

    let purposeTextInputView: LabeledMessageInputView = {
        let labeledMessageInputView = LabeledMessageInputView(
            "Purpose",
            tag: 1,
            placeholder: "Enter the purpose for this trip?"
        )
        labeledMessageInputView.bottomBorder.backgroundColor = .clear
        return labeledMessageInputView
    }()

    let notesTextInputView: LabeledActionView = {
        return LabeledActionView(
            "Notes",
            tag: 1,
            placeholder: "Enter any notes pertaining to this trip"
        )
    }()

    lazy var createButton: AmadaButton = {
        let button = AmadaButton("Create")
        button.backgroundColor = UIColor.MainColors.lightColor
        button.addTarget(self, action: #selector(createTrip), for: .touchUpInside)
        return button
    }()

    lazy var updateButton: AmadaButton = {
        let button = AmadaButton("Update")
        button.backgroundColor = UIColor.MainColors.lightColor
        button.addTarget(self, action: #selector(updateTrip), for: .touchUpInside)
        return button
    }()

    lazy var deleteButton: AmadaButton = {
        let button = AmadaButton("Delete")
        button.backgroundColor = UIColor.MainColors.red
        button.addTarget(self, action: #selector(deleteTrip), for: .touchUpInside)
        return button
    }()

    lazy var submitButton: AmadaButton = {
        let button = AmadaButton("Submit")
        button.backgroundColor = UIColor.MainColors.green
        button.addTarget(self, action: #selector(submitTrip), for: .touchUpInside)
        return button
    }()

    let topAlertMessageView: AlertMessageView = {
        let alertMessageView = AlertMessageView()
        alertMessageView.titleColor = UIColor.MainColors.red
        alertMessageView.alpha = 0
        return alertMessageView
    }()

    /*
    let labeledAWASearchView: LabeledAWANumberSearchView = {
        let view = LabeledAWANumberSearchView("AWA Number",
                                              tag: 1,
                                              placeholder: "Attach an AWA")
        return view
    }()
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if lowPowerModeON() {
            self.batteryModeAlert()
        }
        checkForUser()
        getTableColumnRef()

        if let tabBarController = tabBarController as? TabBarController {
            tabBarController.isHidden = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if _canUpdate {
            tripNameInputView.field.becomeFirstResponder()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func getTableColumnRef() {
        CoreDataManager.shared.getAAI_TABLE_COLUMN_REF { (models, error) in
            guard let models = models else {
                self.presentAlert(title: "Error", message: error.localizedDescription)
                return
            }
            let tripTypes = models.filter({ $0.COLUMN_NAME == "TRIP_TYPE" })
            self.tripTypePickerView.models = tripTypes
        }
    }

    func setup() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = closeNavbarButtonItem

        view.addSubview(scrollView)
        scrollView.addSubview(topAlertMessageView)
        scrollView.addSubview(titleView)
        scrollView.addSubview(tripTypePickerView)
        scrollView.addSubview(tripNameInputView)
        scrollView.addSubview(tripStartTimeView)
        scrollView.addSubview(tripEndTimeView)
        scrollView.addSubview(cashOnHandTextView)
        scrollView.addSubview(cashAdvancedHandTextView)
        //scrollView.addSubview(labeledAWASearchView)
        scrollView.addSubview(purposeTextInputView)
        scrollView.addSubview(notesTextInputView)


        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 1700)

        let viewWidth = view.bounds.width - 50

        topAlertMessageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topAlertMessageView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        topAlertMessageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        titleView.topAnchor.constraint(equalTo: topAlertMessageView.bottomAnchor).isActive = true
        titleView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        tripNameInputView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10).isActive = true
        tripNameInputView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        tripNameInputView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        tripTypePickerView.topAnchor.constraint(equalTo: tripNameInputView.bottomAnchor, constant: 10).isActive = true
        tripTypePickerView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        tripTypePickerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        tripStartTimeView.delegate = self
        tripStartTimeView.topAnchor.constraint(equalTo: tripTypePickerView.bottomAnchor).isActive = true
        tripStartTimeView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        tripStartTimeView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true

        tripEndTimeView.delegate = self
        tripEndTimeView.topAnchor.constraint(equalTo: tripStartTimeView.bottomAnchor).isActive = true
        tripEndTimeView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        tripEndTimeView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true

        cashOnHandTextView.topAnchor.constraint(equalTo: tripEndTimeView.bottomAnchor).isActive = true
        cashOnHandTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        cashOnHandTextView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true

        cashAdvancedHandTextView.topAnchor.constraint(equalTo: cashOnHandTextView.bottomAnchor).isActive = true
        cashAdvancedHandTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        cashAdvancedHandTextView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true

        /*labeledAWASearchView.delegate = self
        labeledAWASearchView.topAnchor.constraint(equalTo: cashAdvancedHandTextView.bottomAnchor).isActive = true
        labeledAWASearchView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        labeledAWASearchView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true*/

        purposeTextInputView.topAnchor.constraint(equalTo: cashAdvancedHandTextView.bottomAnchor).isActive = true
        purposeTextInputView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        purposeTextInputView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true

        notesTextInputView.delegate = self
        notesTextInputView.topAnchor.constraint(equalTo: purposeTextInputView.bottomAnchor).isActive = true
        notesTextInputView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        notesTextInputView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true

        if let exp_hdr = trip {
            if let exp_status = exp_hdr.EXP_STATUS {
                if exp_status == "REJECTED" {
                    if let mgr_reject_reason = exp_hdr.MGR_REJECTED_REASON {
                        topAlertMessageView.title = "Reject Reason"
                        topAlertMessageView.message = mgr_reject_reason
                        topAlertMessageView.alpha = 1
                    }

                    if let acc_reject_reason = exp_hdr.MGR_REJECTED_REASON {
                        topAlertMessageView.title = "Reject Reason"
                        topAlertMessageView.message = acc_reject_reason
                        topAlertMessageView.alpha = 1
                    }
                }
            }
            if _canUpdate {
                if let trip_exp_dtl = expenseList {
                    if trip_exp_dtl.count > 0 {
                        setupAllActions(viewWidth: viewWidth)
                        return
                    }
                }
                setupUpdateAndDeleteActions(viewWidth: viewWidth)
            }
        } else {
            setupCreateTripButton(viewWidth)
        }
    }

    func setupCreateTripButton(_ viewWidth: CGFloat) {
        view.addSubview(createButton)

        createButton.topAnchor.constraint(equalTo: notesTextInputView.bottomAnchor, constant: 10).isActive = true
        createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createButton.width = viewWidth
    }

    func setupUpdateAndDeleteActions(viewWidth: CGFloat) {
        view.addSubview(updateButton)
        view.addSubview(deleteButton)

        updateButton.topAnchor.constraint(equalTo: notesTextInputView.bottomAnchor, constant: 10).isActive = true
        updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        updateButton.width = viewWidth

        deleteButton.topAnchor.constraint(equalTo: updateButton.bottomAnchor, constant: 10).isActive = true
        deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deleteButton.width = viewWidth
    }

    func setupAllActions(viewWidth: CGFloat) {
        let halfWidth = (viewWidth / 2) - 5

        view.addSubview(updateButton)
        view.addSubview(submitButton)
        view.addSubview(deleteButton)

        updateButton.topAnchor.constraint(equalTo: notesTextInputView.bottomAnchor, constant: 10).isActive = true
        updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        updateButton.width = viewWidth

        submitButton.topAnchor.constraint(equalTo: updateButton.bottomAnchor, constant: 10).isActive = true
        submitButton.leftAnchor.constraint(equalTo: updateButton.leftAnchor).isActive = true
        submitButton.width = halfWidth

        deleteButton.topAnchor.constraint(equalTo: updateButton.bottomAnchor, constant: 10).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: updateButton.rightAnchor).isActive = true
        deleteButton.width = halfWidth
    }

    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }

    func checkForUser() {
        let (storedUser, error) = CoreDataManager.shared.getCurrentUser()
        if error != nil {
            dismiss(animated: true, completion: nil)
            return
        }

        if storedUser == nil {
            dismiss(animated: true, completion: nil)
            return
        }
    }

    @objc func handleDismissKeyboard() {
        view.endEditing(true)
    }
}
