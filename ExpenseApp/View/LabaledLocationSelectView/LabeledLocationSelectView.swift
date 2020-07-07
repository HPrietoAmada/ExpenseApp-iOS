//
//  LocationSelectView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/14/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import GooglePlaces

protocol LabeledLocationSelectViewDelegate {
    func present(_ gmsAutocompleteViewController: GMSAutocompleteViewController, tag: Int)
    func labeledLocationSelectView(_ labeledLocationSelectView: LabeledLocationSelectView, gmsAutocompleteViewController: GMSAutocompleteViewController, placeChosen place: GMSPlace, tag: Int)
    func dismiss(_ gmsAutocompleteViewController: GMSAutocompleteViewController)
}

class LabeledLocationSelectView: UIView {

    var value: Int?

    private var heightLayoutConstraint: NSLayoutConstraint?

    var delegate: LabeledLocationSelectViewDelegate?

    var placeholder: String?

    var height: CGFloat = 100

    var place: GMSPlace? {
        didSet {
            guard let place = place else {
                descriptionTitle = ""
                return
            }
            descriptionTitle = place.name ?? ""
        }
    }

    var title: String = "" {
        didSet {
            label.text = title
        }
    }

    var descriptionTitle: String = "" {
        didSet {
            if descriptionTitle.underestimatedCount == 0 {
                button.setTitleColor(UIColor.placeholder, for: .normal)
                guard let placeholder = placeholder else {
                    return
                }
                button.setTitle(placeholder, for: .normal)
            } else {
                button.setTitleColor(UIColor.black, for: .normal)
                button.setTitle(descriptionTitle, for: .normal)
            }
        }
    }

    /* View Components */
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor.MainColors.darkGray
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font =  UIFont(name: "HelveticaNeue", size: 18)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor.placeholder, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleButtonClicked), for: .touchUpInside)
        return button
    }()

    let bottomBorder: Border = {
        return Border()
    }()

    init(_ label: String, tag:Int, placeholder: String = "") {
        super.init(frame: CGRect.zero)
        self.label.text = label
        self.button.setTitle(placeholder, for: .normal)
        self.inputView?.tag = tag
        self.placeholder = placeholder
        self.initialzeViews()
    }

    func initialzeViews() {
        translatesAutoresizingMaskIntoConstraints = false
        // Add Components to View
        addSubview(self.label)
        addSubview(self.button)
        addSubview(self.bottomBorder)

        // button Constraints
        button.topAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // button.delegate = self

        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true

        // Label Constraints
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true

        display()
    }

    func setPlace(placeID: String) {
        let placesClient = GMSPlacesClient()
        placesClient.lookUpPlaceID(placeID) { (place, error) in
            if let _ = error {
                return
            }
            self.place = place
        }
    }

    func reset() {
        place = nil
    }

    @objc func handleButtonClicked() {
        guard let delegate = delegate else {
            return
        }
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        autocompleteController.view.backgroundColor = UIColor.white
        autocompleteController.tableCellBackgroundColor = UIColor.white
        autocompleteController.tintColor = UIColor.white
        delegate.present(autocompleteController, tag: tag)
    }

    func display(_ display: Bool = true) {
        alpha = display ? 1 : 0
        heightLayoutConstraint?.constant = display ? height : 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
