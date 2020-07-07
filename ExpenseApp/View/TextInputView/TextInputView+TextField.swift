//
//  TextInputView+TextField.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/13/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension TextInputView: UITextViewDelegate {

    func initTextView() {
        self.textView.delegate = self
    }

    func setTextViewText(text: String) {
        textView.text = text
        textView.textColor = .black
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textView.textColor == UIColor.lightGray {
            self.textView.text = nil
            self.textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        guard let placeholder = self.placeholder else {
            return
        }
        if self.textView.text.isEmpty {
            self.textView.text = placeholder
            self.textView.textColor = .lightGray
        }
    }
}
