//
//  ButtonCollectionViewFooter.swift
//  AmadaTimeOff
//
//  Created by IT Support on 10/18/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol ButtonCollectionViewFooterDelegate {
    func footerButtonClicked(_ buttonCollectionViewFooter: ButtonCollectionViewFooter)
}

class ButtonCollectionViewFooter: UICollectionReusableView {
    let XBOUNDS: CGFloat = 30
    let YBOUNDS: CGFloat = 15

    var delegate: ButtonCollectionViewFooterDelegate?

    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        button.backgroundColor = UIColor.MainColors.mainColor
        button.setTitle("Begin Creating Expenses", for: .normal)
        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        return button
    }()

    let topBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        addSubview(button)
        addSubview(topBorder)

        translatesAutoresizingMaskIntoConstraints = false

        heightAnchor.constraint(equalToConstant: 80).isActive = true

        button.heightAnchor.constraint(equalTo: heightAnchor, constant: -(YBOUNDS * 2)).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: widthAnchor, constant: -(XBOUNDS * 2)).isActive = true

        topBorder.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topBorder.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }

    @objc func onClick(_ sender: UIButton) {
        guard let delegate = delegate else {
            return
        }
        delegate.footerButtonClicked(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
