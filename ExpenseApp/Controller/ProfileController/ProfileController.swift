//
//  ProfileController.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/9/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    /* Global Variables */
    
    /* Components */
    let titleView: TitleView = {
        let mainTitleView = TitleView()
        mainTitleView.titleTextView.text = "Pauline Kong"
        mainTitleView.subtitleTextView.text = "IT: Business Systems Analyst"
        mainTitleView.titleTextView.textColor = UIColor.black
        mainTitleView.titleTextView.textAlignment = .center
        mainTitleView.subtitleTextView.textAlignment = .center
        mainTitleView.translatesAutoresizingMaskIntoConstraints = false
        return mainTitleView
    }()
    
    let weeklyExpenseReportButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.MainColors.lightColor
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        button.setTitle("Weekly Expense Report", for: .normal)
        button.layer.borderColor = UIColor.MainColors.lightColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleWeeklyExpenseReportButtonClick), for: .touchUpInside)
        return button
    }()
    
    let preApprovedMeetingRequestButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.MainColors.lightColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor.MainColors.lightColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        button.setTitle("Pre-approved Meeting Request", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePreApprovedMeetingButtonClick), for: .touchUpInside)
        return button
    }()

    let managerApprovalsButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.MainColors.red.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor.MainColors.red
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        button.setTitle("Expense Approvals", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePreApprovedMeetingButtonClick), for: .touchUpInside)
        return button
    }()
    
    /* Controller LifeCycle Methods */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGradientBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.initializeViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    /* Creates new BackGround View with gradien */
    func setGradientBackground() {
        let colorTop = UIColor.MainColors.lightGray.cgColor
        let colorBot = UIColor.white.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBot]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.view.bounds
        self.view.layer.addSublayer(gradientLayer)
    }
    
    /* Initialize Controller Component Constraints */
    func initializeViews() {
        // Add Components to Controller's View
        self.view.addSubview(self.titleView)
        self.view.addSubview(self.preApprovedMeetingRequestButton)
        self.view.addSubview(self.weeklyExpenseReportButton)
        self.view.addSubview(self.managerApprovalsButton)
        
        // Desired View Components Widths 'For aesthetic purposes only'
        let viewWidth = self.view.bounds.width - 50
        
        // Expense Report Button Constraints
        self.weeklyExpenseReportButton.topAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.weeklyExpenseReportButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.weeklyExpenseReportButton.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        self.weeklyExpenseReportButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Absence Report Button Constraints
        self.preApprovedMeetingRequestButton.topAnchor.constraint(equalTo: self.weeklyExpenseReportButton.bottomAnchor, constant: 15).isActive = true
        self.preApprovedMeetingRequestButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.preApprovedMeetingRequestButton.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        self.preApprovedMeetingRequestButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        // Manager Approvals Button Constraints
        self.managerApprovalsButton.topAnchor.constraint(equalTo: self.preApprovedMeetingRequestButton.bottomAnchor, constant: 15).isActive = true
        self.managerApprovalsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.managerApprovalsButton.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        self.managerApprovalsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // TitleView Constraints
        self.titleView.bottomAnchor.constraint(equalTo: self.weeklyExpenseReportButton.topAnchor, constant: -50).isActive = true
        self.titleView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
        self.titleView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
    }
    
    /* Sets top bar(where battery is displayed) to either white or black */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}











