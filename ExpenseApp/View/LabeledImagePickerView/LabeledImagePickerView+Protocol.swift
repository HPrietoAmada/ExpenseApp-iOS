//
//  LabeledImagePickerView+Protocol.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/20/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension LabeledImagePickerView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        guard let delegate = delegate else {
            return
        }

        delegate.labeledImagePickerView(self, canceled: picker)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            return
        }

        addImage(image: image)
        
        guard let delegate = delegate else {
            return
        }

        print("image selected")

        delegate.labeledImagePickerView(self, imageSelected: picker, image: image)
    }
}
