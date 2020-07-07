//
//  DataDisplayTableViewCell.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/14/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

class ExpenseModelTableViewCell: UITableViewCell {

    var _bounds: CGFloat = 20 {
        didSet {

        }
    }

    var expenseModel: TripModel? {
        didSet {
            guard let model = expenseModel,
                let trip = model.Trip else {
                return
            }

            if let trip_name = trip.TRIP_NAME {
                tripNameLabel.text = trip_name
            }

            if let expenseStatus = trip.EXP_STATUS {
                expenseStatusLabel.text = expenseStatus
            }

            if let beg_date_str = trip.BEG_DATE, let beg_date = beg_date_str.toDateTime() {
                startDateLabel.text = beg_date.getFormattedDate()
            }

            if let end_date_str = trip.END_DATE, let end_date = end_date_str.toDateTime() {
                endDateLabel.text = end_date.getFormattedDate()
            }

            if let purpose = trip.PURPOSE {
                purposeLabel.text = purpose
            } else {
                purposeLabel.text = "None"
            }

            if let notes = trip.NOTES {
                notesLabel.text = notes
            } else {
                notesLabel.text = "None"
            }

            guard let expenses = model.Expenses else {
                return
            }

            var total: Double = 0
            expenses.forEach { (exp_dtl) in
                if let total_amount = exp_dtl.TOTAL_AMOUNT {
                    total = total + total_amount
                }
            }

            costLabel.text = "$\(total.formatted())"
        }
    }

    let tripNameLabel: TextView = {
        let label = TextView()
        label.text = "Trip Name"
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.textContainer.maximumNumberOfLines = 1
        label.textColor = UIColor.MainColors.lightColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let expenseStatusTitleLabel: TextView = {
        let label = TextView()
        label.text = "STATUS"
        label.textContainer.maximumNumberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let expenseStatusLabel: TextView = {
        let label = TextView()
        label.textContainer.maximumNumberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let costTitleLabel: TextView = {
        let label = TextView()
        label.text = "TOTAL AMOUNT"
        label.textContainer.maximumNumberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let costLabel: TextView = {
        let label = TextView()
        label.textContainer.maximumNumberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let startDateTitleLabel: TextView = {
        let label = TextView()
        label.text = "START DATE"
        label.textContainer.maximumNumberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let startDateLabel: TextView = {
        let label = TextView()
        label.textContainer.maximumNumberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let endDateTitleLabel: TextView = {
        let label = TextView()
        label.text = "END DATE"
        label.textContainer.maximumNumberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let endDateLabel: TextView = {
        let label = TextView()
        label.textContainer.maximumNumberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let purposeTitleLabel: TextView = {
        let label = TextView()
        label.text = "PURPOSE"
        label.textContainer.maximumNumberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let purposeLabel: TextView = {
        let label = TextView()
        label.textContainer.maximumNumberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let notesTitleLabel: TextView = {
        let label = TextView()
        label.text = "NOTES"
        label.textContainer.maximumNumberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let notesLabel: TextView = {
        let label = TextView()
        label.textContainer.maximumNumberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bottomBorder: Border = {
        let borderView = Border()
        return borderView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    func setup() {
        selectionStyle = .none
        addSubview(tripNameLabel)
        addSubview(expenseStatusTitleLabel)
        addSubview(expenseStatusLabel)
        addSubview(costTitleLabel)
        addSubview(costLabel)
        addSubview(startDateTitleLabel)
        addSubview(startDateLabel)
        addSubview(endDateTitleLabel)
        addSubview(endDateLabel)
        addSubview(purposeTitleLabel)
        addSubview(purposeLabel)
        addSubview(notesTitleLabel)
        addSubview(notesLabel)
        addSubview(bottomBorder)

        tripNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: _bounds).isActive = true
        tripNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: _bounds).isActive = true
        tripNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -_bounds).isActive = true

        expenseStatusTitleLabel.leftAnchor.constraint(equalTo: tripNameLabel.leftAnchor).isActive = true
        expenseStatusTitleLabel.rightAnchor.constraint(equalTo: centerXAnchor).isActive = true
        expenseStatusTitleLabel.topAnchor.constraint(equalTo: tripNameLabel.bottomAnchor).isActive = true

        expenseStatusLabel.leftAnchor.constraint(equalTo: expenseStatusTitleLabel.leftAnchor).isActive = true
        expenseStatusLabel.rightAnchor.constraint(equalTo: expenseStatusTitleLabel.rightAnchor).isActive = true
        expenseStatusLabel.topAnchor.constraint(equalTo: expenseStatusTitleLabel.bottomAnchor).isActive = true

        costTitleLabel.leftAnchor.constraint(equalTo: centerXAnchor).isActive = true
        costTitleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        costTitleLabel.topAnchor.constraint(equalTo: expenseStatusTitleLabel.topAnchor).isActive = true

        costLabel.leftAnchor.constraint(equalTo: costTitleLabel.leftAnchor).isActive = true
        costLabel.rightAnchor.constraint(equalTo: costTitleLabel.rightAnchor).isActive = true
        costLabel.topAnchor.constraint(equalTo: expenseStatusLabel.topAnchor).isActive = true

        startDateTitleLabel.leftAnchor.constraint(equalTo: tripNameLabel.leftAnchor).isActive = true
        startDateTitleLabel.rightAnchor.constraint(equalTo: centerXAnchor).isActive = true
        startDateTitleLabel.topAnchor.constraint(equalTo: expenseStatusLabel.bottomAnchor).isActive = true

        startDateLabel.leftAnchor.constraint(equalTo: startDateTitleLabel.leftAnchor).isActive = true
        startDateLabel.rightAnchor.constraint(equalTo: startDateTitleLabel.rightAnchor).isActive = true
        startDateLabel.topAnchor.constraint(equalTo: startDateTitleLabel.bottomAnchor).isActive = true

        endDateTitleLabel.leftAnchor.constraint(equalTo: centerXAnchor).isActive = true
        endDateTitleLabel.rightAnchor.constraint(equalTo: tripNameLabel.rightAnchor).isActive = true
        endDateTitleLabel.topAnchor.constraint(equalTo: startDateTitleLabel.topAnchor).isActive = true

        endDateLabel.leftAnchor.constraint(equalTo: endDateTitleLabel.leftAnchor).isActive = true
        endDateLabel.rightAnchor.constraint(equalTo: endDateTitleLabel.rightAnchor).isActive = true
        endDateLabel.topAnchor.constraint(equalTo: startDateLabel.topAnchor).isActive = true

        purposeTitleLabel.leftAnchor.constraint(equalTo: tripNameLabel.leftAnchor).isActive = true
        purposeTitleLabel.rightAnchor.constraint(equalTo: tripNameLabel.rightAnchor).isActive = true
        purposeTitleLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor).isActive = true

        purposeLabel.leftAnchor.constraint(equalTo: purposeTitleLabel.leftAnchor).isActive = true
        purposeLabel.rightAnchor.constraint(equalTo: purposeTitleLabel.rightAnchor).isActive = true
        purposeLabel.topAnchor.constraint(equalTo: purposeTitleLabel.bottomAnchor).isActive = true

        notesTitleLabel.leftAnchor.constraint(equalTo: tripNameLabel.leftAnchor).isActive = true
        notesTitleLabel.rightAnchor.constraint(equalTo: tripNameLabel.rightAnchor).isActive = true
        notesTitleLabel.topAnchor.constraint(equalTo: purposeLabel.bottomAnchor).isActive = true

        notesLabel.leftAnchor.constraint(equalTo: notesTitleLabel.leftAnchor).isActive = true
        notesLabel.rightAnchor.constraint(equalTo: notesTitleLabel.rightAnchor).isActive = true
        notesLabel.topAnchor.constraint(equalTo: notesTitleLabel.bottomAnchor).isActive = true
        notesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -_bounds).isActive = true

        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: tripNameLabel.leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: tripNameLabel.rightAnchor).isActive = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
