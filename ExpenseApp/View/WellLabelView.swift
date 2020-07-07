//
//  CapsuleLabelView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 5/22/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class WellLabelView: UIView {

    let topHalfView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let topHalfLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bottomHalfView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let bottomHalfLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initializeView()
    }

    init(topTitle: String, bottomTitle: String) {
        super.init(frame: CGRect.zero)
        self.topHalfLabel.text = topTitle
        self.bottomHalfLabel.text = bottomTitle
        self.initializeView()
    }

    func initializeView() {
        // Design self
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 4

        // Add components to view
        self.addSubview(self.topHalfView)
        self.addSubview(self.bottomHalfView)
        self.addSubview(self.topHalfLabel)
        self.addSubview(self.bottomHalfLabel)

        // Constraints
        self.setTopHalfViewConstraints()
        self.setBottomHalfViewConstraints()
        self.setTopHalfLabelConstraints()
        self.setBottomHalfLabelConstraints()
    }

    func setTopHalfViewConstraints() {
        self.topHalfView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.topHalfView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.topHalfView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.topHalfView.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    func setBottomHalfViewConstraints() {
        self.bottomHalfView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.bottomHalfView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.bottomHalfView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.bottomHalfView.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    func setTopHalfLabelConstraints() {
        self.topHalfLabel.bottomAnchor.constraint(equalTo: self.topHalfView.bottomAnchor, constant: -2).isActive = true
        self.topHalfLabel.centerXAnchor.constraint(equalTo: self.topHalfView.centerXAnchor).isActive = true
    }

    func setBottomHalfLabelConstraints() {
        self.bottomHalfLabel.topAnchor.constraint(equalTo: self.bottomHalfView.topAnchor, constant: 2).isActive = true
        self.bottomHalfLabel.centerXAnchor.constraint(equalTo: self.bottomHalfView.centerXAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
