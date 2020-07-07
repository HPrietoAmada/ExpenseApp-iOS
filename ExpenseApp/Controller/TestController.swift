//
//  TestController.swift
//  AmadaTimeOff
//
//  Created by IT Support on 11/22/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    let setCountView: SetCountView = {
        let setCountView = SetCountView()
        return setCountView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        view.addSubview(setCountView)

        view.backgroundColor = .white

        setCountView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        setCountView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
}
