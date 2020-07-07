//
//  ScrollView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/19/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class ScrollView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        print("ScrollView init")
        setup()
    }

    func setup() {
        bounces = true
        isUserInteractionEnabled = true
        showsVerticalScrollIndicator = true
        tintColor = UIColor.white
        isScrollEnabled = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
