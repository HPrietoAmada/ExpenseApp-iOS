//
//  MileageExpenseCell.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/17/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
// import MapboxDirections
import MapKit
import GooglePlaces

class ExpenseTableViewCell: UITableViewCell {
    
    /* Cell Data Model */
    var exp_dtl: EXP_DTL? {
        didSet {
            guard let exp_dtl = exp_dtl else {
                return
            }

            // User input location only
            if let end_loc_name = exp_dtl.END_LOC_NAME {
                descriptionTextView.text = end_loc_name
            } else {
                if let beg_loc_name = exp_dtl.BEG_LOC_NAME {
                    descriptionTextView.text = beg_loc_name
                } else {
                    descriptionTextView.text = ""
                }
            }

            if let notes = exp_dtl.NOTES {
                titleTextView.text = notes
            } else {
                titleTextView.text = ""
            }

            // Set description if one exists.

            if let exp_desc = exp_dtl.EXP_TYPE_DESCRIPTION {
                self.titleTextView.text = exp_desc
            } else {
                titleTextView.text = ""
            }


            if let odomStart = exp_dtl.ODO_FROM,
                let odomEnd = exp_dtl.ODO_TO,
                let odoUOM = exp_dtl.ODO_UOM {
                let distance = Int(odomEnd - odomStart)
                milesTextView.text = "\(distance) \(odoUOM)."
            } else {
                milesTextView.text = ""
            }

            if let begDate = exp_dtl.EXP_BEG_DATE_FORMATTED {
                dateTextView.text = begDate
            }

            if let total_amount = exp_dtl.TOTAL_AMOUNT {
                totalTextView.text = "$\(total_amount.formatted())"
            } else {
                totalTextView.text = ""
            }
        }
    }

    var status: Int? {
        didSet {
            switch status {
            case 1:
                self.setStatusLabel(text: "REJECTED", borderColor: UIColor.MainColors.red)
            case 2:
                self.setStatusLabel(text: "APPROVED", borderColor: UIColor.MainColors.green)
            default:
                self.setStatusLabel(text: "SUBMITTED", borderColor: .lightGray)
            }
        }
    }

    func setStatusLabel(text: String, borderColor: UIColor) {
        self.statusLabel.text = text
        self.statusLabel.textColor = .white
        self.statusLabel.layer.borderColor = borderColor.cgColor
        self.statusLabel.alpha = 1
        self.statusLabel.backgroundColor = borderColor
    }
    
    /* TableViewCell Components */
    let titleTextView: TextView = {
        let label = TextView()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalTextView: TextView = {
        let label = TextView()
        label.textAlignment = .right
        label.textColor = UIColor.MainColors.lightColor
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionTextView: TextView = {
        let label = TextView()
        label.textAlignment = .left
        label.textColor = UIColor.gray
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let milesTextView: TextView = {
        let label = TextView()
        label.textAlignment = .right
        // label.textColor = .black
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateTextView: TextView = {
        let label = TextView()
        label.textAlignment = .left
        // label.textColor = .black
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MainColors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 9)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.widthAnchor.constraint(equalToConstant: 75).isActive = true
        label.alpha = 0
        return label
    }()
    
    /* TableViewCell Constructor */
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    /* Adds UIComponents to TableViewCell's View */
    func setup() {
        // Add views to Custom TableCellView
        selectionStyle = .none
        backgroundColor = UIColor.clear
        addSubview(self.dateTextView)
        addSubview(self.titleTextView)
        addSubview(self.totalTextView)
        addSubview(self.milesTextView)
        //addSubview(self.descriptionTextView)
        addSubview(self.statusLabel)
        addSubview(self.bottomBorder)

        // self.cellView.layer.cornerRadius = 5
        
        titleTextView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: centerXAnchor).isActive = true

        totalTextView.leftAnchor.constraint(equalTo: titleTextView.rightAnchor).isActive = true
        totalTextView.topAnchor.constraint(equalTo: titleTextView.topAnchor).isActive = true
        totalTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        /*
        descriptionTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: titleTextView.leftAnchor).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: totalTextView.rightAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: dateTextView.topAnchor).isActive = true
        */
        dateTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor).isActive = true
        dateTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        dateTextView.leftAnchor.constraint(equalTo: titleTextView.leftAnchor).isActive = true
        dateTextView.rightAnchor.constraint(equalTo: centerXAnchor).isActive = true

        milesTextView.leftAnchor.constraint(equalTo: dateTextView.rightAnchor).isActive = true
        milesTextView.bottomAnchor.constraint(equalTo: dateTextView.bottomAnchor).isActive = true
        milesTextView.rightAnchor.constraint(equalTo: totalTextView.rightAnchor).isActive = true
        
        self.bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        self.bottomBorder.rightAnchor.constraint(equalTo: totalTextView.rightAnchor).isActive = true
        self.bottomBorder.leftAnchor.constraint(equalTo: titleTextView.leftAnchor).isActive = true

        self.statusLabel.centerYAnchor.constraint(equalTo: titleTextView.centerYAnchor).isActive = true
        self.statusLabel.rightAnchor.constraint(equalTo: totalTextView.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setMealTypeDescription(expenseMealType: String) {
        CoreDataManager.shared.getAAI_TABLE_COLUMN_REF { (tableColRef, error) in
            guard let tableColRef = tableColRef, let expenseMealTypeChar = expenseMealType.last else {
                return
            }
            let mealTypeColRefs = tableColRef.filter({ $0.COLUMN_NAME == "MEAL_TYPE" })
            let mealTypeColRef = mealTypeColRefs.first(where: { $0.COLUMN_VALUE == "\(expenseMealTypeChar)" })

            guard let mealTypeRef = mealTypeColRef, let mealType = mealTypeRef.DESCRIPTION else {
                return
            }
            self.titleTextView.text = "Meal (\(mealType))"
        }
    }
}
