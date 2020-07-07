//
//  ControllerTitleView.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/12/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class TitleView: UIView {

    var title: String = "" {
        didSet {
            titleTextView.text = title
        }
    }

    var subtitle: String = "" {
        didSet {
            subtitleTextView.text = subtitle
        }
    }
    
    /* View Components */
    let titleTextView: TextView = {
        let textView = TextView()
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.black
        textView.textAlignment = .left
        textView.textContainer.maximumNumberOfLines = 2
        textView.font = UIFont(name: "HelveticaNeue-Medium", size: 32)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let subtitleTextView: TextView = {
        let textView = TextView()
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.black
        textView.textAlignment = .left
        textView.font = UIFont(name: "HelveticaNeue", size: 18)
        textView.textContainer.maximumNumberOfLines = 3
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    /* Constructor for View */
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setup()
    }
    
    init(_ title: String, subtitle: String) {
        super.init(frame: CGRect.zero)
        self.titleTextView.text = title
        self.subtitleTextView.text = subtitle
        self.setup()
    }
    
    func setup() {
        // Add Components to View
        addSubview(titleTextView)
        addSubview(subtitleTextView)

        translatesAutoresizingMaskIntoConstraints = false
        // Title Label Constraints
        self.titleTextView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.titleTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        self.titleTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        // Description Label Constraints
        self.subtitleTextView.topAnchor.constraint(equalTo: self.titleTextView.bottomAnchor).isActive = true
        self.subtitleTextView.leftAnchor.constraint(equalTo: titleTextView.leftAnchor).isActive = true
        self.subtitleTextView.rightAnchor.constraint(equalTo: titleTextView.rightAnchor).isActive = true

        self.bottomAnchor.constraint(equalTo: self.subtitleTextView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
