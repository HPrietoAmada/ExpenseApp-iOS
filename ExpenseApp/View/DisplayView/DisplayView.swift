//
//  TimeOffSelectionView.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/9/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class DisplayView: UIView {

    private var heightLayoutConstraint: NSLayoutConstraint?
    private var heightConstant: CGFloat?

    /* View Components */
    let primaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.textColor = UIColor.MainColors.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Regular", size: 18)
        label.textAlignment = .right
        label.textColor = UIColor.MainColors.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bottomDivider: Border = {
        return Border()
    }()
    
    /* 'Constructor' for View */
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setup()
    }

    init(primaryText: String,
         secondaryText: String) {
        super.init(frame: CGRect.zero)
        primaryLabel.text = primaryText
        secondaryLabel.text = secondaryText
        self.setup()
    }

    func setup() {
        // Adds Components to View
        self.addSubview(self.primaryLabel)
        self.addSubview(self.secondaryLabel)
        self.addSubview(self.bottomDivider)

        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Section Label Constraints
        self.primaryLabel.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
        self.primaryLabel.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        
        // Section Switch Constraints
        self.secondaryLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.secondaryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        // Bottom Divider Constraints
        self.bottomDivider.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.bottomDivider.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.bottomDivider.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        // Set View HeightAnchor
        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: 70)
        heightLayoutConstraint?.isActive = true
    }

    func setHeight(height: CGFloat) {
        heightLayoutConstraint?.constant = height
        heightConstant = height
    }

    func display(_ display: Bool = true) {
        alpha = display ? 1 : 0
        if let heightConstant = heightConstant {
            heightLayoutConstraint?.constant = display ? heightConstant : 0
        } else {
            heightLayoutConstraint?.constant = display ? 70 : 0
        }
    }
    
    func setFieldsColor(color: UIColor) {
        self.secondaryLabel.textColor = color
        self.primaryLabel.textColor = color
        self.bottomDivider.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
