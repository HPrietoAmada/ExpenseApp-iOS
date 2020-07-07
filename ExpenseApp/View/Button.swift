//
//  Button.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/17/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    required init(title: String) {
        super.init(frame: CGRect.zero)
        self.setTitle(title, for: .normal)
        self.initializeViews()
    }
    
    func initializeViews() {
        // Customize Button
        self.backgroundColor = UIColor.MainColors.lightColor
        self.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        
        // Button Margins
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
