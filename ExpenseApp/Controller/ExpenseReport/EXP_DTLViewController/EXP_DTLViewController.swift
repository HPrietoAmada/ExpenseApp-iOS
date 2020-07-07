//
//  CreateExpenseController.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/12/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import GooglePlaces

class EXP_DTLViewController: UIViewController {

    var tag: Int = 0

    var _formSubmitDelegate: UIViewControllerFormSubmitDelegate?
    /*
     Tells the controller that values in input fields can be updated or just for viewing purposes
     */
    var canUpdate: Bool = true {
        didSet {
            createMode = false
            scrollView.subviews.forEach { view in
                view.isUserInteractionEnabled = canUpdate
                view.isMultipleTouchEnabled = canUpdate
            }
        }
    }

    /*
     Tells the controller that the user is creating, and not updating or other, an expense
     */
    var createMode: Bool = false

    var _tableColRef: [AAI_TABLE_COLUMN_REF] = [AAI_TABLE_COLUMN_REF]() {
        didSet {
            let expenseTypes = _tableColRef.filter({ $0.COLUMN_NAME == "EXPENSE_TYPE" })
            let mealTypes = _tableColRef.filter({ $0.COLUMN_NAME?.uppercased().contains("MEAL") != nil })
            let mileageRates = _tableColRef.filter({ $0.COLUMN_NAME == "MILEAGE_RATE" })

            setExpenseTypes(expenseTypes: expenseTypes)
            setMealTableColRefPickers(models: mealTypes)
            setMileageRates(mileageRates: mileageRates)
        }
    }

    var exp_hdr: EXP_HDR? {
        didSet {
            guard let exp_hdr = exp_hdr else {
                return
            }

            guard let beg_date_str = exp_hdr.BEG_DATE,
                let beg_date = beg_date_str.toDateTime(),
                let end_date_str = exp_hdr.END_DATE,
                let end_date = end_date_str.toDateTime() else {
                    return
            }

            if _expense == nil {
                expBegDateTimePickerView.date = beg_date
                expBegDateTimePickerView.minDate = beg_date
                expBegDateTimePickerView.maxDate = end_date

                expEndDateTimePickerView.date = end_date
                expEndDateTimePickerView.minDate = beg_date
                expEndDateTimePickerView.maxDate = end_date
            }
        }
    }

    var _expense: EXP_DTL? {
        didSet {
            guard let exp_dtl = _expense else {
                return
            }
            let expenseTypes = _tableColRef.filter({ $0.COLUMN_NAME == "EXPENSE_TYPE" })
            let mealTypes = _tableColRef.filter({ $0.COLUMN_NAME == "MEAL_TYPE" })
            let mealLocations = _tableColRef.filter({ $0.COLUMN_NAME == "MEAL_LOCATION" })
            let mealAllowances = _tableColRef.filter({ $0.COLUMN_NAME == "MEAL_ALLOWANCE" })

            if let exp_desc = exp_dtl.EXP_DESC,
                let expTypeValue = expenseTypes.first(where: {
                    $0.DESCRIPTION == exp_desc
                }) {
                expenseTypePicker._value = expTypeValue
            }

            if let exp_beg_date_str = exp_dtl.EXP_BEG_DATE,
                let exp_beg_date = exp_beg_date_str.toDateTime() {
                expBegDateTimePickerView.date = exp_beg_date
            }

            if let exp_end_date_str = exp_dtl.EXP_END_DATE,
                let exp_end_date = exp_end_date_str.toDateTime() {
                expEndDateTimePickerView.date = exp_end_date
            }

            if let originPlaceID = exp_dtl.BEG_LOC_ADDR2 {
                begLatLonSelectView.setPlace(placeID: originPlaceID)
            }

            if let destinationPlaceID = exp_dtl.END_LOC_ADDR2 {
                endLatLonLocationSelectView.setPlace(placeID: destinationPlaceID)
            }

            if let mealType = exp_dtl.MEAL_TYPE, let mealTypeRef = mealTypes.first(where: { $0.COLUMN_VALUE == mealType }) {
                mealTypePicker._value = mealTypeRef
            }

            if let round_trip_flag = exp_dtl.ROUND_TRIP_FLAG {
                roundTripCheckboxView.isChecked = round_trip_flag.uppercased() == "Y"
            }

            if let odo_uom = exp_dtl.ODO_UOM {
                odoUOMPicker._description = odo_uom
            }

            if let odom_start = exp_dtl.ODO_FROM {
                odoFromViewNumberPad.field.text = "\(odom_start)"
            }

            if let odom_end = exp_dtl.ODO_TO {
                odoToViewNumberPad.field.text = "\(odom_end)"
            }

            if let currency = exp_dtl.CURRENCY,
                let currency_row = CURRENCY_TYPES.firstIndex(of: currency) {
                currencyTypePicker.picker.selectRow(currency_row, inComponent: 0, animated: false)
                currencyTypePicker.text = currency
            }

            if let tip_amount = exp_dtl.TIPS_AMOUNT {
                tipsNumberPad.text = "\(tip_amount)"
            }

            if let total_amount = exp_dtl.TOTAL_AMOUNT {
                totalAmountNumberPad.field.text = "\(total_amount)"
            }

            if let notes = exp_dtl.NOTES {
                notesInputView.text = notes
            }

            if let per_diem_flag = exp_dtl.PER_DIEM_FLAG {
                perDiemCheckboxView.isChecked = per_diem_flag.uppercased() == "Y"
            }
        }
    }

    var _guestList: [EXP_DTL_GUESTS] = [EXP_DTL_GUESTS]() {
        didSet {
            guestSelectView._description = "\(_guestList.count) guest(s) selected"
        }
    }

    let CURRENCY_TYPES = [
        "USD",
        "PESO",
        "YEN",
        "CANADIAN"
    ]

    /* Global Variables */
    var formViewLeftConstraint: NSLayoutConstraint?
    var formViewRightConstraint: NSLayoutConstraint?

    lazy var doneNavbarButtonItem: TextNavbarButtonItem = {
        let textNavbarButtonItem = TextNavbarButtonItem("Done")
        textNavbarButtonItem.action = #selector(handleDetailCancel)
        textNavbarButtonItem.target = self
        return textNavbarButtonItem
    }()

    let topBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.tintColor = UIColor.white
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = UIColor.clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let titleView: TitleView = {
        let titleView = TitleView("Create Expense",
                                  subtitle: "")

        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()

    let expenseTypePicker: LabeledTableColumnRefPickerView = {
        let pickerView = LabeledTableColumnRefPickerView("Expense Type",
                                                         placeholder: "Select Expense",
                                                         tag: 1)
        //pickerView.toolbarDoneButton.action = #selector(handleDismissKeyboard)
        return pickerView
    }()

    let expBegDateTimePickerView: LabeledTimePickerView = {
        let datePicker = LabeledTimePickerView("Start Date (within trip date range)",
                                                 tag: 1,
                                                 placeholder: "Select the start date and time of this expense")
        datePicker.dateFormat = "MMM dd, yyyy hh:mm a"
        datePicker.datePicker.datePickerMode = .dateAndTime
        return datePicker
    }()

    let expEndDateTimePickerView: LabeledTimePickerView = {
        let datePicker = LabeledTimePickerView("End Date (within trip date range)",
                                                 tag: 2,
                                                 placeholder: "Select the end date and time of this expense")
        datePicker.datePicker.datePickerMode = .dateAndTime
        datePicker.dateFormat = "MMM dd, yyyy hh:mm a"
        return datePicker
    }()

    let mealTypePicker: LabeledTableColumnRefPickerView = {
        let pickerView = LabeledTableColumnRefPickerView("Meal Type",
                                    placeholder: "Select the Meal Type",
                                    tag: 2)
        // pickerView.toolbarDoneButton.action = #selector(handleDismissKeyboard)
        return pickerView
    }()

    let mealLocationPicker: LabeledTableColumnRefPickerView = {
        let pickerView = LabeledTableColumnRefPickerView("Meal Per Diem Location",
                                    placeholder: "Continental U.S. & U.S. Territories",
                                    tag: 3)
        return pickerView
    }()

    let mealAllowancePicker: LabeledTableColumnRefPickerView = {
        let pickerView = LabeledTableColumnRefPickerView(
            "",
            placeholder: "",
            tag: 4
        )
        return pickerView
    }()

    let currencyTypePicker: PickerView = {
        let pickerView = PickerView(
            "Currency Type",
            labels: [
                "USD",
                "PESO",
                "YEN",
                "CANADIAN"
            ],
            placeholder: "USD"
        )
        pickerView.toolbarDoneButton.action = #selector(handleDismissKeyboard)
        return pickerView
    }()

    let odoUOMPicker: LabeledTableColumnRefPickerView = {
        let pickerView = LabeledTableColumnRefPickerView("Odometer Unit of Measure",
                                    placeholder: "MI")
        // pickerView.toolbarDoneButton.action = #selector(handleDismissKeyboard)
        return pickerView
    }()

    let odoFromViewNumberPad: LabeledTextField = {
        let labeledTextField = LabeledTextField("Odometer Start",
                                                tag: 2,
                                                placeholder: "Enter odometer reading at the START of your trip")

        labeledTextField.field.keyboardType = .numberPad
        labeledTextField.toolBarDone.action = #selector(handleDismissKeyboard)
        labeledTextField.translatesAutoresizingMaskIntoConstraints = false
        return labeledTextField
    }()

    let odoToViewNumberPad: LabeledTextField = {
        let labeledTextField = LabeledTextField("Odometer End",
                                                tag: 3,
                                                placeholder: "Enter odometer reading at the END of your trip")

        labeledTextField.field.keyboardType = .numberPad
        labeledTextField.toolBarDone.action = #selector(handleDismissKeyboard)
        labeledTextField.translatesAutoresizingMaskIntoConstraints = false
        return labeledTextField
    }()

    let totalAmountNumberPad: LabeledTextField = {
        let labeledTextField = LabeledTextField("Amount Paid",
                                                tag: 5,
                                                placeholder: "Enter amount paid out of pocket")

        labeledTextField.field.keyboardType = .decimalPad
        labeledTextField.toolBarDone.action = #selector(handleDismissKeyboard)
        labeledTextField.translatesAutoresizingMaskIntoConstraints = false
        return labeledTextField
    }()

    let tipsNumberPad: LabeledTextField = {
        let labeledTextField = LabeledTextField("Tip",
                                                tag: 6,
                                                placeholder: "Enter tip amount")
        labeledTextField.field.keyboardType = .decimalPad
        labeledTextField.toolBarDone.action = #selector(handleDismissKeyboard)
        labeledTextField.translatesAutoresizingMaskIntoConstraints = false
        return labeledTextField
    }()

    let attachReceiptsImagePickerView: LabeledImagePickerView = {
        let labeledImagePickerView = LabeledImagePickerView(
            "Receipt Image",
            tag: 1
        )
        return labeledImagePickerView
    }()

    let createExpenseButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.isEnabled = true
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.MainColors.lightColor
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold",
                                         size: 16)

        button.setTitle("Create Expense", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(handleCreateExpense),
                         for: .touchUpInside)
        return button
    }()

    lazy var updateExpenseButton: AmadaButton = {
        let button = AmadaButton("Update Expense")
        button.buttonColor = UIColor.MainColors.lightColor
        button.titleColor = .white
        button.addTarget(self, action: #selector(handleUpdateExpense), for: .touchUpInside)
        return button
    }()

    let begLatLonSelectView: LabeledLocationSelectView = {
        let locationSelectView = LabeledLocationSelectView(
            "Origin",
            tag: 2,
            placeholder: "Select the Origin of this expense"
        )
        return locationSelectView
    }()

    let endLatLonLocationSelectView: LabeledLocationSelectView = {
        let locationSelectView = LabeledLocationSelectView(
            "Destination",
            tag: 3,
            placeholder: "Select the Destination of this expense"
        )
        return locationSelectView
    }()

    let roundTripCheckboxView: CheckboxView = {
        let checkbox = CheckboxView("Was this a round trip?")
        checkbox.tag = 1
        return checkbox
    }()

    let notesInputView: LabeledMessageInputView = {
        let messageInputView = LabeledMessageInputView(
            "Notes",
            tag: 1,
            placeholder: "Enter any notes pertaining to this expense"
        )
        messageInputView.bottomBorder.backgroundColor = .clear
        return messageInputView
    }()

    let guestSelectView: LabeledActionView = {
        let view = LabeledActionView(
            "Guests",
            tag: 1,
            placeholder: "Select any guests that attended this expense"
        )
        return view
    }()

    let perDiemCheckboxView: CheckboxView = {
        let checkbox = CheckboxView("Was this per diem?")
        checkbox.tag = 2
        return checkbox
    }()

    let mealMiscTypePicker: LabeledTableColumnRefPickerView = {
        let picker = LabeledTableColumnRefPickerView(
            "Meal Type",
            placeholder: "Select the Meal Type",
            tag: 5
        )
        picker._selectionRequired = false
        return picker
    }()

    let mealMiscLocationPicker: LabeledTableColumnRefPickerView = {
        let picker = LabeledTableColumnRefPickerView(
            "Meal Location",
            placeholder: "Select the Meal Location",
            tag: 6
        )
        picker._selectionRequired = false
        return picker
    }()

    let progressIndicator: ProgressIndicator = {
        let progressIndicator = ProgressIndicator(text: "Creating Expense...")
        return progressIndicator
    }()

    /* Controller LifeCycle Methods */
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        initializeMileageDetailComponents()
        setSubtitleText()
        setupNavbarItems()
        initializeDetailPickers()
        getDropdownOptions()

        // Keyboard observers
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillHide),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )

        if lowPowerModeON() {
            presentAlert(
                title: "LOW POWER MODE ON",
                message: "Turn OFF \"Low Power Mode\" before creating an Expense."
            )
            return
        }

        view.addSubview(progressIndicator)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let tabBarController = tabBarController as? TabBarController {
            tabBarController.isHidden = true
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    /* Initializes UIComponents to View */
    func initializeMileageDetailComponents() {
        let updatingExpense = _expense != nil

        if updatingExpense {
            titleView.title = "Update Expense"
        }

        // Add Components to View
        view.addSubview(scrollView)
        view.addSubview(topBorder)

        // Mileage Detail Border Constraints
        topBorder.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        topBorder.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topBorder.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topBorder.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
    }

    func setSubtitleText() {
        let (currentUser, error) = CoreDataManager.shared.getCurrentUser()
        if error != nil {
            return
        }

        guard let user = currentUser,
            let displayName = user.display_name else {
            return
        }

        if let exp_hdr = exp_hdr {
            if let trip_name = exp_hdr.TRIP_NAME {
                titleView.subtitle = "\(displayName) - \(trip_name)"
            } else {
                titleView.subtitle = displayName
            }
        } else {
            titleView.subtitle = displayName
        }
    }

    func setupNavbarItems() {
        navigationItem.leftBarButtonItem = doneNavbarButtonItem
    }

    @objc func navBack() {
        navigationController?.popViewController(animated: true)
    }
}

/*

 struct EXP_DTL: Codable {
     public var ID: Int?
     public var EXP_ID: Int?
     public var EXP_LINE: Int?
     public var EXP_DESC: String?
     public var EXP_BEG_DATE: Date?
     public var EXP_END_DATE: Date?
     public var MEAL_TYPE: String?
     public var CURRENCY: String?
     public var TOTAL_AMOUNT: Double?
     public var NET_AMOUNT: Double?
     public var TIPS_AMOUNT: Double?
     public var EXC_RATE: Double?
     public var ROUND_TRIP_FLAG: String?
     public var ODO_UOM: String?
     public var ODO_FROM: String?
     public var ODO_TO: String?
     public var BEG_LAT: Double?
     public var BEG_LON: Double?
     public var END_LAT: Double?
     public var END_LON: Double?
     public var MILEAGE_RATE: Double?
     public var BEG_LOC_NAME: String?
     public var BEG_LOC_ADDR1: String?
     public var BEG_LOC_ADDR2: String?
     public var BEG_LOC_CITY: String?
     public var BEG_LOC_STATE: String?
     public var BEG_LOC_COUNTRY: String?
     public var END_LOC_NAME: String?
     public var END_LOC_ADDR1: String?
     public var END_LOC_ADDR2: String?
     public var END_LOC_CITY: String?
     public var END_LOC_STATE: String?
     public var END_LOC_COUNTRY: String?
     public var CREATED_DATE: Date?
     public var CREATED_BY: String?
     public var CHANGED_DATE: Date?
     public var CHANGED_BY: String?
     public var NOTES: String?
 }

 */
