//
//  BlankCollectionReuseCell.swift
//  AmadaTimeOff
//
//  Created by IT Support on 10/18/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class BlankCollectionReuseCell: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
