//
//  TextNavbarButtonItem.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/19/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class TextNavbarButtonItem: UIBarButtonItem {

    var fontSize: CGFloat = 14 {
        didSet {
            setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: font, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)], for: .normal)
        }
    }

    var font: String = "HelveticaNeue" {
        didSet {
            setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: font, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)], for: .normal)
        }
    }

    override init() {
        super.init()
        setup()
    }

    init(_ title: String) {
        super.init()
        setup()
        self.title = title
    }

    private func setup() {
        style = UIBarButtonItem.Style.plain
        tintColor = .black
        setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14),], for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
