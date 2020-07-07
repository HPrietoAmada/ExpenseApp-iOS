//
//  SetCountView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 11/22/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol SetCountViewDelegate {
    func setCountViewDelegate(_ setCountView: SetCountView, countChanged count: Int, tag: Int)
}

class SetCountView: UIView {

    var delegate: SetCountViewDelegate?

    var count: Int = 0 {
        didSet {
            count = count < minLimit ? minLimit : count
            count = count > maxLimit ? maxLimit : count

            minusButton.isEnabled = count > minLimit
            plusButton.isEnabled = count < maxLimit

            minusButton.alpha = minusButton.isEnabled ? 1.0 : 0.5
            plusButton.alpha = plusButton.isEnabled ? 1.0 : 0.5

            countLabel.text = "\(count)+"
        }
    }

    var maxLimit: Int = 10 {
        didSet {

        }
    }

    var minLimit: Int = 0 {
        didSet {

        }
    }

    var fontSize: CGFloat = 11 {
        didSet {
            countLabel.font = UIFont(name: "HelveticaNeue", size: fontSize)
        }
    }

    lazy var minusButton: UIButton = {
        let minus = UIImage(named: "minus-main")
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 11)
        button.setImage(minus, for: .normal)
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.MainColors.mainColor.cgColor
        button.layer.borderWidth = 1.5
        button.tintColor = UIColor.MainColors.mainColor
        button.translatesAutoresizingMaskIntoConstraints = false

        let dims: CGFloat = 40
        button.layer.cornerRadius = dims / 2
        button.widthAnchor.constraint(equalToConstant: dims).isActive = true
        button.heightAnchor.constraint(equalToConstant: dims).isActive = true

        button.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        return button
    }()

    lazy var plusButton: UIButton = {
        let plus = UIImage(named: "plus-main")
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 11)
        button.setImage(plus, for: .normal)
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.MainColors.mainColor.cgColor
        button.layer.borderWidth = 1.5
        button.tintColor = UIColor.MainColors.mainColor
        button.translatesAutoresizingMaskIntoConstraints = false

        let dims: CGFloat = 40
        button.layer.cornerRadius = dims / 2
        button.widthAnchor.constraint(equalToConstant: dims).isActive = true
        button.heightAnchor.constraint(equalToConstant: dims).isActive = true

        button.addTarget(self, action: #selector(increment), for: .touchUpInside)
        return button
    }()

    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.text = "0+"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    fileprivate func setup() {
        addSubview(minusButton)
        addSubview(plusButton)
        addSubview(countLabel)

        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 150).isActive = true

        countLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        countLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        countLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true

        minusButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        minusButton.rightAnchor.constraint(equalTo: countLabel.leftAnchor).isActive = true

        plusButton.leftAnchor.constraint(equalTo: countLabel.rightAnchor).isActive = true
        plusButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }

    @objc func decrement() {
        count -= 1
        guard let delegate = delegate else {
            return
        }

        delegate.setCountViewDelegate(self, countChanged: count, tag: tag)
    }

    @objc func increment() {
        count += 1
        guard let delegate = delegate else {
            return
        }

        delegate.setCountViewDelegate(self, countChanged: count, tag: tag)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
