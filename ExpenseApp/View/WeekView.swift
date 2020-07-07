//
//  WeekView.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/16/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class WeekView: UIView {
    
    let stackView: UIStackView = {
        // Days of the week label
        let sn = CalenderDayLabel()
        sn.text = "S"
        let m = CalenderDayLabel()
        m.text = "M"
        let t = CalenderDayLabel()
        t.text = "T"
        let w = CalenderDayLabel()
        w.text = "W"
        let th = CalenderDayLabel()
        th.text = "T"
        let f = CalenderDayLabel()
        f.text = "F"
        let s = CalenderDayLabel()
        s.text = "S"
        let stackView = UIStackView(arrangedSubviews: [sn,m,t,w,th,f,s])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MainColors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initializeViews()
    }
    
    func initializeViews() {
        // StackView Parameters
        self.addSubview(self.stackView)
        self.addSubview(self.bottomBorder)
        
        // StackView Constraints
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        self.stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // BottomBorder Constraints
        self.bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.heightAnchor.constraint(equalToConstant: 31).isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
