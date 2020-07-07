//
//  CalenderDayLabel.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/11/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class CalenderDayLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.textColor = UIColor.black
        self.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
