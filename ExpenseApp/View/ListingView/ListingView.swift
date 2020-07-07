//
//  ListingView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/22/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class ItemDisplayView: UIView {

    let BOUNDS:CGFloat = 25
    let IMAGE_DIMS:CGFloat = 85
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 15)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        label.textColor = .darkGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 15)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.widthAnchor.constraint(equalToConstant: 85).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        return imageView
    }()

    let border: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
    }

    init(title: String,
         description: String,
         caption: String,
         price: CGFloat)
    {
        super.init(frame: CGRect.zero)
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.captionLabel.text = caption
        self.priceLabel.text = "$\(price)"
        self.initializeViewWithoutImage()
    }

    init(image: UIImage,
         title: String,
         description: String,
         caption: String,
         price: CGFloat)
    {
        super.init(frame: CGRect.zero)
        self.imageView.image = image
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.priceLabel.text = "$\(price)"
        self.captionLabel.text = caption
        self.initializeViewWithImage()
    }

    func initializeViewWithoutImage() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.priceLabel)
        self.addSubview(self.captionLabel)
        self.addSubview(self.border)

        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.BOUNDS).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.BOUNDS).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.BOUNDS).isActive = true

        self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.BOUNDS).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.BOUNDS).isActive = true

        self.priceLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 5).isActive = true
        self.priceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.BOUNDS).isActive = true
        self.priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.BOUNDS).isActive = true

        self.captionLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 5).isActive = true
        self.captionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.BOUNDS).isActive = true
        self.captionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.BOUNDS).isActive = true

        self.bottomAnchor.constraint(equalTo: self.captionLabel.bottomAnchor, constant: self.BOUNDS).isActive = true

        self.border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.border.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -(self.BOUNDS * 2)).isActive = true
        self.border.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.border.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }

    func initializeViewWithImage() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.priceLabel)
        self.addSubview(self.captionLabel)
        self.addSubview(self.imageView)
        self.addSubview(self.border)

        self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.BOUNDS).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.BOUNDS).isActive = true

        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.BOUNDS).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.BOUNDS).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.imageView.leftAnchor, constant: -10).isActive = true

        self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.BOUNDS).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.imageView.leftAnchor, constant: -10).isActive = true

        self.priceLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 5).isActive = true
        self.priceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.BOUNDS).isActive = true
        self.priceLabel.rightAnchor.constraint(equalTo: self.imageView.leftAnchor, constant: -10).isActive = true

        self.captionLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 5).isActive = true
        self.captionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.BOUNDS).isActive = true
        self.captionLabel.rightAnchor.constraint(equalTo: self.imageView.leftAnchor, constant: -10).isActive = true

        self.bottomAnchor.constraint(equalTo: self.captionLabel.bottomAnchor, constant: self.BOUNDS).isActive = true

        self.border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.border.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -(self.BOUNDS * 2)).isActive = true
        self.border.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.border.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
