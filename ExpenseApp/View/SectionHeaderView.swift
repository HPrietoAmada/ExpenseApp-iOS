//
//  TimeOffSectionHeader.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/9/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class SectionHeaderView: UIView {
    
    /* View Components */
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomDivider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MainColors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /* 'Constructor' method for View */
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initializeView()
    }
    
    func initializeView() {
        // Add Components to View
        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.dividerView)
        self.addSubview(self.bottomDivider)
        
        // Divider View Constraints
        self.dividerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.dividerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.dividerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Title Label Constraints
        self.titleLabel.bottomAnchor.constraint(equalTo: self.dividerView.topAnchor, constant: -2.5).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        // Description Label Constraints
        self.descriptionLabel.topAnchor.constraint(equalTo: self.dividerView.topAnchor, constant: 2.5).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    /* Calculates View's height given title and subtitle text */
    func getHeight(_ viewWidth: CGFloat) -> CGFloat {
        guard let titleText = self.titleLabel.text else {
            return 10.0
        }
        var height = self.getTextHeight(titleText, font: 23, viewWidth: viewWidth)
        if let subtitleText = self.descriptionLabel.text {
            height += self.getTextHeight(subtitleText, font: 16, viewWidth: viewWidth)
        }
        return height
    }
    
    /* Returns the Height of some text given parameters */
    private func getTextHeight(_ text: String, font: CGFloat, viewWidth: CGFloat) -> CGFloat {
        return NSString(string: text).boundingRect(with: CGSize(width: viewWidth*0.9, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: font)], context: nil).height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
