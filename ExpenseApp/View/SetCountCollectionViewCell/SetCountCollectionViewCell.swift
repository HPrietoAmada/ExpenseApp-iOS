//
//  SetCountCollectionViewCell.swift
//  AmadaTimeOff
//
//  Created by IT Support on 11/23/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol SetCountCollectionViewCellDelegate {
    func countChanged(_ setCountCollectionViewCell: SetCountCollectionViewCell, count: Int, indexPath: IndexPath)
}

class SetCountCollectionViewCell: UICollectionViewCell, SetCountViewDelegate {

    private let BOUNDS: CGFloat = 30

    var delegate: SetCountCollectionViewCellDelegate?

    var count: Int = 0 {
        didSet {
            setCountView.count = count
        }
    }

    var indexPath: IndexPath?

    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 19)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    let setCountView: SetCountView = {
        let setCountView = SetCountView()
        return setCountView
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        addSubview(title)
        addSubview(setCountView)

        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor, constant: BOUNDS).isActive = true

        setCountView.delegate = self
        setCountView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        setCountView.rightAnchor.constraint(equalTo: rightAnchor, constant: -BOUNDS/2).isActive = true
    }

    func setCountViewDelegate(_ setCountView: SetCountView, countChanged count: Int, tag: Int) {
        guard let delegate = delegate,
            let indexPath = indexPath else {
                print("Delegate not set.")
            return
        }
        print("delegate set.")
        delegate.countChanged(self, count: count, indexPath: indexPath)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
