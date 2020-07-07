//
//  MessageViewController.swift
//  ExpenseApp
//
//  Created by IT Support on 5/24/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

/*

 1.) console.cloud.google.com
 2.) Select 'AmadaDev' project
 3.) Select 'SQL' from left side menu
 4.) Click amada-dev
 5.) under 'Connect to this instance' click on 'Connect using Cloud Shell'
 6.) Click enter when terminal connects
 7.) Enter Password: Am@d@2o2o

 */

import UIKit

protocol TextInputViewControllerDelegate {
    func textInputViewController(_ controller: TextInputViewController, primaryButtonClicked message: String, tag: Int)
    func textInputViewController(_ controller: TextInputViewController, secondaryButtonClicked message: String, tag: Int)
}

class TextInputViewController: UIViewController {

    var tag: Int = 0

    var delegate: TextInputViewControllerDelegate?
    var _title: String = "" {
        didSet {
            messageFullView.titleTextView.text = _title
        }
    }

    var _description: String = "" {
        didSet {
            messageFullView.descriptionTextView.text = _description
        }
    }

    var _primary: String = "" {
        didSet {
            messageFullView.primaryButton.setTitle(_primary, for: .normal)
        }
    }

    var _secondary: String = "" {
        didSet {
            messageFullView.secondaryButton.setTitle(_secondary, for: .normal)
        }
    }

    var showClose: Bool = true {
        didSet {
            //navigationItem.setHidesBackButton(!showClose, animated: true)
        }
    }

    lazy var closeNavbarButtonItem: CloseNavbarButtonItem = {
        let closeNavbarButtonItem = CloseNavbarButtonItem()
        closeNavbarButtonItem.action = #selector(handleCancel)
        closeNavbarButtonItem.target = self
        return closeNavbarButtonItem
    }()

    let messageFullView: MessageFullView = {
        let messageFullView = MessageFullView(title: "Title", description: "Description")
        messageFullView.primaryButton.addTarget(self, action: #selector(handlePrimaryButtonClick), for: .touchUpInside)
        messageFullView.secondaryButton.addTarget(self, action: #selector(handleSecondaryButtonClick), for: .touchUpInside)
        return messageFullView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageFullView.textView.becomeFirstResponder()
    }

    func setup() {
        view.addSubview(messageFullView)

        messageFullView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageFullView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        messageFullView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        messageFullView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

        if showClose {
            //navigationItem.leftBarButtonItem = closeNavbarButtonItem
        }
    }

    @objc func handlePrimaryButtonClick() {
        if let delegate = delegate, let text = messageFullView.textView.text {
            delegate.textInputViewController(self, primaryButtonClicked: text, tag: tag)
        }
    }

    @objc func handleSecondaryButtonClick() {
        if let delegate = delegate, let text = messageFullView.textView.text {
            delegate.textInputViewController(self, secondaryButtonClicked: text, tag: tag)
        }
        dismiss(animated: true, completion: nil)
    }

    @objc func handleCancel() {
        if !showClose { return }
        dismiss(animated: true, completion: nil)
    }
}
