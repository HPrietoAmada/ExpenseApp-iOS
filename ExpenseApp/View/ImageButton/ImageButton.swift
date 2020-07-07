//
//  ImageButton.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/15/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class ImageButton: UIButton {

    private var heightLayoutConstraint: NSLayoutConstraint?
    private var heightConstant: CGFloat?

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    init(image: UIImage)
    {
        super.init(frame: CGRect.zero)
        setImage(image, for: .normal)
        setup()
    }

    func setup()
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        contentMode = .center
        imageView?.contentMode = .scaleAspectFit
        backgroundColor = UIColor.lightGray

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: 40)
        heightLayoutConstraint?.isActive = true
    }

    func setHeight(height: CGFloat)
    {
        heightLayoutConstraint?.constant = height
        heightConstant = height
    }

    func display(_ display: Bool = true)
    {
        alpha = display ? 1 : 0
        guard let heightConstant = heightConstant else {
            heightLayoutConstraint?.constant = display ? 40 : 0
            return
        }

        heightLayoutConstraint?.constant = display ? heightConstant : 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
