//
//  CloseNavbarItem.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/19/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class CloseNavbarButtonItem: UIBarButtonItem {

    override init() {
        super.init()
        setup()
    }

    private func setup() {
        let image = UIImage(named: "Delete")
        style = UIBarButtonItem.Style.plain
        self.image = image
        tintColor = .black
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
