//
//  InputFieldWithTitle.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/12/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class InputFieldWithTitle: UIView {
    
    /* View Components */
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.textColor = UIColor.MainColors.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.clear
        textField.textColor = UIColor.MainColors.darkGray
        textField.tintColor = UIColor.MainColors.darkGray
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        return textField
    }()
    
    let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MainColors.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /* 'Constructor' for View */
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initializeViews()
    }
    
    func initializeViews() {
        // Add Components to View
        self.addSubview(self.label)
        self.addSubview(self.textField)
        self.addSubview(self.bottomBorder)
        
        // Label Constraints
        self.label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        // TextField Constraints
        self.textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.textField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.textField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.textField.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 5).isActive = true
        
        // BottomBorder Constraints
        self.bottomBorder.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        self.bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.bottomBorder.topAnchor.constraint(equalTo: self.textField.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
