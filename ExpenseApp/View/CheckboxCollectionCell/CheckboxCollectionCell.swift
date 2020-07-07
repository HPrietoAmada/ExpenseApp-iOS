//
//  CheckboxView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 10/18/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol CheckboxCollectionCellDelegate {
    func didCheck(_ checkboxCollectionCell: CheckboxCollectionCell, isChecked: Bool, row: Int)
}

class CheckboxCollectionCell: UICollectionViewCell {

    private let BOUNDS: CGFloat = 30

    var delegate: CheckboxCollectionCellDelegate?

    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                checkboxView.backgroundColor = UIColor.MainColors.mainColor
                checkboxView.layer.borderColor = UIColor.MainColors.mainColor.cgColor
                checkmarkImageView.alpha = 1
            } else {
                checkboxView.backgroundColor = UIColor.clear
                checkboxView.layer.borderColor = UIColor.lightGray.cgColor
                checkmarkImageView.alpha = 0
            }
        }
    }

    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 19)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var checkboxView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 3.5
        view.layer.borderColor = UIColor.MainColors.lightGray.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false

        let checkboxBounds: CGFloat = 25
        view.heightAnchor.constraint(equalToConstant: checkboxBounds).isActive = true
        view.widthAnchor.constraint(equalToConstant: checkboxBounds).isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonClicked))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "checkmark25")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        imageView.isUserInteractionEnabled = false
        return imageView
    }()

    let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MainColors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        addSubview(title)
        addSubview(checkboxView)
        addSubview(bottomBorder)
        checkboxView.addSubview(checkmarkImageView)

        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor, constant: BOUNDS).isActive = true

        checkboxView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkboxView.rightAnchor.constraint(equalTo: rightAnchor, constant: -BOUNDS).isActive = true

        let padding: CGFloat = 3.5
        checkmarkImageView.topAnchor.constraint(equalTo: checkboxView.topAnchor, constant: padding).isActive = true
        checkmarkImageView.rightAnchor.constraint(equalTo: checkboxView.rightAnchor, constant: -padding).isActive = true
        checkmarkImageView.leftAnchor.constraint(equalTo: checkboxView.leftAnchor, constant: padding).isActive = true
        checkmarkImageView.bottomAnchor.constraint(equalTo: checkboxView.bottomAnchor, constant: -padding).isActive = true

        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: checkboxView.rightAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: title.leftAnchor).isActive = true

        isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        isChecked = !isChecked
        guard let delegate = delegate else {
            return
        }
        delegate.didCheck(self, isChecked: isChecked, row: tag)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
