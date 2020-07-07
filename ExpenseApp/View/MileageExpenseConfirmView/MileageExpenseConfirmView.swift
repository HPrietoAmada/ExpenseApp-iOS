//
//  MileageExpenseConfirmView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 6/27/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class MileageExpenseConfirmView: UIView {

    /* Controller Components */
    let navbar: UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.barStyle = .default
        navbar.barTintColor = UIColor.clear
        navbar.backgroundColor = UIColor.clear
        navbar.tintColor = UIColor.black
        navbar.isTranslucent = true
        navbar.isOpaque = false
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        return navbar
    }()

    let navbarItems: UINavigationItem = {
        let navItems = UINavigationItem()
        navItems.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: nil)
        return navItems
    }()

    let titleView: TitleView = {
        let titleView = TitleView("Mileage Expense Report", subtitle: "Review before submitting")
        return titleView
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initializeView()
    }

    func initializeView() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false

        self.navbar.setItems([self.navbarItems], animated: false)

        self.addSubview(self.navbar)
        self.addSubview(self.titleView)

        // Navbar Constraints
        self.navbar.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.navbar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.navbar.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        self.titleView.topAnchor.constraint(equalTo: self.navbar.bottomAnchor, constant: 20).isActive = true
        self.titleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        self.titleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
