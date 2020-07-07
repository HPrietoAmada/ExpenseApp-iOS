//
//  ProfileCellView.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/9/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class CellView: UIView {
    
    /* View Components */
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.textColor = UIColor.MainColors.darkGray
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MainColors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /* Constructor for View */
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initializeView()
    }

    init(description: String, _ imageName: String = "right_arrow_gray") {
        super.init(frame: CGRect.zero)
        self.descriptionLabel.text = description
        self.imageView.image = UIImage(named: imageName)
        self.initializeView()
    }

    init(description: String, image: UIImage) {
        super.init(frame: CGRect.zero)
        self.descriptionLabel.text = description
        self.imageView.image = image
        self.initializeView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView() {
        // Adds Components to View
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.imageView)
        self.addSubview(self.separatorView)
        
        // Description Label Constraints
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        // Image View Constraints
        self.imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        // Separator View Constraints
        self.separatorView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.separatorView.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
        self.separatorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.separatorView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        // Height Anchor for this View
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
