//
//  ClearTextView+Protocols.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/19/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension ClearTextView: UITextViewDelegate {
    func setTextViewText(text: String) {
        self.text = text
        textColor = .black
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textColor == UIColor.lightGray {
            text = nil
            textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        guard let placeholder = placeholder else {
            return
        }
        if text.isEmpty {
            text = placeholder
            textColor = .lightGray
        }
    }
}
