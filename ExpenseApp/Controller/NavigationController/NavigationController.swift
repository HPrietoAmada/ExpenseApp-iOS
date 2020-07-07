//
//  CustomNavigationController.swift
//  AmadaTimeOff
//
//  Created by IT Support on 10/18/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    func setupNavbar() {
        navigationBar.isHidden = false
        navigationBar.backgroundColor = .white
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .black
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
