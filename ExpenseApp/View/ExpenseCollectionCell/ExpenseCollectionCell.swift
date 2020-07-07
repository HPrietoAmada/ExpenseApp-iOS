//
//  ExpenseCollectionCell.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/12/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class ExpenseCollectionCell: UICollectionViewCell {

    /* Cell Data Model */
    var mileageExpense: MileageExpense? {
        didSet {
            guard let employee = self.mileageExpense?.employee,
                let _ = self.mileageExpense?.odomStart,
                let _ = self.mileageExpense?.odomEnd,
                let _ = self.mileageExpense?.gasRate else {
                    return
            }

            // Set required fields to Cell
            if let totalExpense = self.mileageExpense?.getTotalExpense() {
                self.totalLabel.text = "$\(totalExpense)"
            }
            self.titleLabel.text = "La Mirada, CA \(employee)"

            if let milesTraveled = self.mileageExpense?.getTotalMiles() {
                self.milesLabel.text = "\(milesTraveled) mi."
            }

            // Set description if one exists.
            if let description = self.mileageExpense?.purpose {
                self.descriptionLabel.text = description
            }

            if let timestamp = self.mileageExpense?.timestamp {
                print("Timestamp:   \(timestamp)")
            }
        }
    }

    /* TableViewCell Components */
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        // view.layer.masksToBounds = true
        // view.layer.cornerRadius = 5
        // view.layer.borderWidth = 1
        // view.layer.borderColor = UIColor.MainColors.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let totalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.MainColors.lightColor
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.gray
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let milesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.backgroundColor = UIColor.clear
        label.text = "Jan 8, 2018"
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

    /* TableViewCell Constructor */
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initializeViews()
    }

    /* Adds UIComponents to TableViewCell's View */
    func initializeViews() {
        // Add views to Custom TableCellView
        self.backgroundColor = UIColor.clear
        self.addSubview(self.cellView)
        self.cellView.addSubview(self.dateLabel)
        self.cellView.addSubview(self.titleLabel)
        self.cellView.addSubview(self.totalLabel)
        self.cellView.addSubview(self.milesLabel)
        self.cellView.addSubview(self.descriptionLabel)
        self.cellView.addSubview(self.bottomBorder)

        // CellView Constraints
        self.cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

        // self.cellView.layer.cornerRadius = 5

        // Description Label: Centered Vertically in Cell
        self.descriptionLabel.centerYAnchor.constraint(equalTo: self.cellView.centerYAnchor).isActive = true
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.cellView.leftAnchor, constant: 25).isActive = true

        // TitleLabel Constraints
        self.titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -3.5).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.cellView.leftAnchor, constant: 25).isActive = true

        // Date Label Constraints
        self.dateLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 3.5).isActive = true
        self.dateLabel.leftAnchor.constraint(equalTo: self.cellView.leftAnchor, constant: 25).isActive = true

        // Total Amount Label Constraints
        self.totalLabel.rightAnchor.constraint(equalTo: self.cellView.rightAnchor, constant: -25).isActive = true
        self.totalLabel.centerYAnchor.constraint(equalTo: self.descriptionLabel.centerYAnchor).isActive = true

        // Miles Driven Label Constraints
        self.milesLabel.rightAnchor.constraint(equalTo: self.cellView.rightAnchor, constant: -25).isActive = true
        self.milesLabel.centerYAnchor.constraint(equalTo: self.dateLabel.centerYAnchor).isActive = true

        self.bottomBorder.bottomAnchor.constraint(equalTo: self.cellView.bottomAnchor).isActive = true
        self.bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
