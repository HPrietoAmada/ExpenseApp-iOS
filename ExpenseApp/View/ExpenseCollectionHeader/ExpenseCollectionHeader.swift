//
//  ExpenseCollectionHeader.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/12/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class ExpenseCollectionHeaderCell: UICollectionReusableView {

    private let BOUNDS: CGFloat = 20

    var headerTitle: String? {
        didSet {
            guard let title = headerTitle else { return }
            self.titleLabel.text = title
        }
    }

    var headerSubTitle: String? {
        didSet {
            guard let subTitle = headerSubTitle else { return }
            self.subtitleLabel.text = subTitle
        }
    }

    /* View Components */
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.MainColors.darkGray
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.gray
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /* Constructor for View */
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initializeViews()
    }

    func initializeViews() {
        self.backgroundColor = .orange
        // Add Components to View
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)

        // Title Label Constraints
        self.titleLabel.bottomAnchor.constraint(equalTo: self.subtitleLabel.topAnchor).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.BOUNDS).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.BOUNDS).isActive = true

        // Description Label Constraints
        self.subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        self.subtitleLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor).isActive = true
        self.subtitleLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
