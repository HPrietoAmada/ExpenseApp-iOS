//
//  LabeledImagePickerView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/20/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol LabeledImagePickerViewDelegate {
    func labeledImagePickerView(_ labeledImagePickerView: LabeledImagePickerView, linkTapped imagePickerViewController: UIImagePickerController)
    func labeledImagePickerView(_ labeledImagePickerView: LabeledImagePickerView, canceled imagePickerViewController: UIImagePickerController)
    func labeledImagePickerView(_ labeledImagePickerView: LabeledImagePickerView, imageSelected imagePickerViewController: UIImagePickerController, image: UIImage)
    func labeledImagePickerView(_ labeledImagePickerView: LabeledImagePickerView, selectSourceType alertController: UIAlertController)
}

class LabeledImagePickerView: UIView {

    private var heightLayoutConstraint: NSLayoutConstraint?

    var delegate: LabeledImagePickerViewDelegate?

    var height: CGFloat = 100

    var images = [UIImage]()

    var descriptionText: String = "No images selected" {
        didSet {
            descriptionButton.setTitle(descriptionText, for: .normal)

            if images.count == 0 {
                descriptionButton.titleColor = .placeholder
            } else if images.count >= 1 {
                descriptionButton.titleColor = .black
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

    let linkButton: AmadaButton = {
        let button = AmadaButton("Add Image")
        button.buttonColor = .clear
        button.titleColor = UIColor.MainColors.mainColor
        button.height = 50
        button.width = 100
        button.fontType = "HelveticaNeue-Medium"
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .top
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        return button
    }()

    lazy var descriptionButton: AmadaButton = {
        let amadaButton = AmadaButton("No images selected")
        amadaButton.fontSize = 18
        amadaButton.fontType = "HelveticaNeue"
        amadaButton.buttonColor = .clear
        amadaButton.titleColor = UIColor.placeholder
        amadaButton.width = 250
        amadaButton.contentHorizontalAlignment = .left
        amadaButton.addTarget(self, action: #selector(descriptionTapped), for: .touchUpInside)
        return amadaButton
    }()

    let bottomBorder: Border = {
        return Border()
    }()

    init(_ label: String, placeholder: String = "No images selected", tag:Int = 0) {
        super.init(frame: CGRect.zero)
        self.label.text = label
        self.inputView?.tag = tag
        descriptionText = placeholder
        self.initialzeViews()
    }

    @objc func handleTap() {
        guard let delegate = delegate else {
            return
        }

        let alertController = UIAlertController(title: "Adding Receipt", message: "How would you like to access your receipt?", preferredStyle: .alert)
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: handlePhotoLibrarySourceTypeSelected)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: handleCameraSourceTypeSelected)

        alertController.addAction(photoLibraryAction)
        alertController.addAction(cameraAction)

        delegate.labeledImagePickerView(self, selectSourceType: alertController)
    }

    @objc func handlePhotoLibrarySourceTypeSelected(_ handler: UIAlertAction?) {
        guard let delegate = delegate else {
            return
        }
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.sourceType = .photoLibrary
        imagePickerViewController.allowsEditing = true
        imagePickerViewController.delegate = self
        delegate.labeledImagePickerView(self, linkTapped: imagePickerViewController)
    }

    @objc func handleCameraSourceTypeSelected(_ handler: UIAlertAction?) {
        guard let delegate = delegate else {
            return
        }
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.sourceType = .camera
        imagePickerViewController.allowsEditing = true
        imagePickerViewController.delegate = self
        delegate.labeledImagePickerView(self, linkTapped: imagePickerViewController)
    }

    func initialzeViews() {
        translatesAutoresizingMaskIntoConstraints = false
        // Add Components to View
        addSubview(label)
        addSubview(linkButton)
        addSubview(bottomBorder)
        addSubview(descriptionButton)

        // Label Constraints
        label.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: centerXAnchor).isActive = true

        linkButton.topAnchor.constraint(equalTo: label.topAnchor, constant: -5).isActive = true
        linkButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true

        descriptionButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0).isActive = true
        descriptionButton.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true

        display()
    }

    func display(_ display: Bool = true) {
        self.alpha = display ? 1 : 0
        heightLayoutConstraint?.constant = display ? height : 0
    }

    func addImage(image: UIImage) {
        images.append(image)
        descriptionText = images.count == 1 ? "\(images.count) image selected" : "\(images.count) images selected"
    }

    func reset() {
        images = [UIImage]()
        descriptionText = "No images selected"
    }

    @objc func descriptionTapped() {
        print("description tapped")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
