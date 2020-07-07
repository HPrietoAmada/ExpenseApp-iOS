//
//  SettingsViewController.swift
//  ExpenseApp
//
//  Created by IT Support on 5/24/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let scrollView: ScrollView = {
        let scrollView = ScrollView()
        return scrollView
    }()

    let titleView: TitleView = {
        let titleView = TitleView("", subtitle: "")
        return titleView
    }()

    lazy var feedbackView: DisplayView = {
        let displayView = DisplayView(primaryText: "Give us feedback", secondaryText: "")

        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleSendFeedback))
        displayView.addGestureRecognizer(gesture)
        return displayView
    }()

    lazy var logoutView: DisplayView = {
        let displayView = DisplayView(primaryText: "Logout", secondaryText: "")
        displayView.primaryLabel.textColor = UIColor.MainColors.red

        let gesture = UITapGestureRecognizer(target: self, action: #selector(logUserOut))
        displayView.addGestureRecognizer(gesture)
        return displayView
    }()

    let progressIndicator: ProgressIndicator = {
        let progressIndicator = ProgressIndicator(text: "")
        return progressIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func setup() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(progressIndicator)
        scrollView.addSubview(titleView)
        scrollView.addSubview(feedbackView)
        scrollView.addSubview(logoutView)

        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        titleView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        titleView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        feedbackView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10).isActive = true
        feedbackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        feedbackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true

        logoutView.topAnchor.constraint(equalTo: feedbackView.bottomAnchor).isActive = true
        logoutView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
        logoutView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        let (currentUser, error) = CoreDataManager.shared.getCurrentUser()

        if let _ = error {
            return
        }

        guard let user = currentUser else {
            return
        }

        if let displayName = user.display_name {
            titleView.title = displayName
        }
        if let title = user.title {
            titleView.subtitle = title
        } else {
            titleView.subtitle = "Amada Employee"
        }
    }

    @objc func logUserOut() {
        let alertController = UIAlertController(title: "Ending Session", message: "Are you sure you want to log out?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "Log Out", style: .default, handler: { (action) in
            self.progressIndicator.show()
            CoreDataManager.shared.logout({ (success, error) in
                if let error = error {
                    self.progressIndicator.hide()
                    self.presentAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                self.checkUserSesssion()
                self.progressIndicator.hide()
            })
        }))
        present(alertController, animated: true, completion: nil)
    }

    @objc func handleSendFeedback() {
        let controller = TextInputViewController()
        controller._title = "Feedback"
        controller._description = "How can we improve this app?"
        controller._primary = "Send Email"
        controller._secondary = "Cancel"
        controller.delegate = self
        controller.tag = 1
        navigationController?.pushViewController(controller, animated: true)
    }
}
