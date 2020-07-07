//
//  ExpenseTableHeader.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/20/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol ExpenseTableHeaderDelegate {
    func expenseTableHeader(_ header: ExpenseTableHeader, didSelectHeaderAt section: Int)
}

class ExpenseTableHeader: UITableViewHeaderFooterView {

    let BOUNDS: CGFloat = 30

    var collapsed: Bool = false

    var exp_hdr: EXP_HDR? {
        didSet {
            guard let exp_hdr = exp_hdr else {
                return
            }

            if let tripName = exp_hdr.TRIP_NAME, let tripTypeDesc = exp_hdr.TRIP_TYPE_DESCRIPTION {
                title = "\(tripName) (\(tripTypeDesc))"
            } else if let tripName = exp_hdr.TRIP_NAME {
                title = "\(tripName)"
            }

            if let exp_status = exp_hdr.EXP_STATUS {
                status = exp_status
            }

            if let tripTotal = exp_hdr.TRIP_TOTAL, let expStatus = exp_hdr.EXP_STATUS {
                if expStatus == "OPEN" && tripTotal > 0 {
                    self.detail = "$\(tripTotal.formatted())"
                }
            }
        }
    }

    var status: String? {
        didSet {
            guard let status = status else {
                return
            }
            switch status {
            case "SUBMITTED":
                setStatusLabel(text: "SUBMITTED", borderColor: .lightGray)
                break
            case "APPROVED":
                setStatusLabel(text: "APPROVED", borderColor: UIColor.MainColors.green)
                break
            case "REJECTED":
                setStatusLabel(text: "REJECTED", borderColor: UIColor.MainColors.red)
                break
            default :
                statusLabel.alpha = 0
                break
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

    var section: Int?

    var delegate: ExpenseTableHeaderDelegate?

    var title: String = "" {
        didSet {
            self.titleTextView.text = title
        }
    }

    var detail: String = "" {
        didSet {
            detailTextView.text = detail
            detailTextView.alpha = 1
        }
    }

    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let titleTextView: TextView = {
        let textView = TextView()
        textView.font = UIFont(name: "HelveticaNeue-Medium", size: 21)
        textView.textColor = UIColor.MainColors.mainColor
        textView.textContainer.maximumNumberOfLines = 1
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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

    let detailTextView: TextView = {
        let label = TextView()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        return label
    }()

    let topBorder: Border = {
        let borderView = Border()
        //borderView.height = 0.5
        return borderView
    }()

    let bottomBorder: Border = {
        let borderView = Border()
        //borderView.height = 0.5
        return borderView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initializeView()
    }

    func initializeView() {
        addSubview(view)
        view.addSubview(titleTextView)
        view.addSubview(detailTextView)
        view.addSubview(statusLabel)
        view.addSubview(topBorder)
        view.addSubview(bottomBorder)

        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        titleTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        titleTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true

        statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        statusLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true

        detailTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        detailTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true

        topBorder.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topBorder.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topBorder.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        bottomBorder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }

    @objc func handleTap() {
        collapsed = !collapsed
        guard let delegate = delegate else {
            return
        }

        guard let section = section else {
            return
        }

        delegate.expenseTableHeader(self, didSelectHeaderAt: section)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
