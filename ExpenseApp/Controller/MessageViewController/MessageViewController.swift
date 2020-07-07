//
//  MessageViewController.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/13/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

protocol MessageViewControllerDelegate {
    func messageViewController( _ controller: MessageViewController, messageSent message: String, tag: Int)
}

class MessageViewController: UIViewController {

    var tag: Int = 0

    var delegate: MessageViewControllerDelegate?

    private var messageInputViewBottomLayoutConstraint: NSLayoutConstraint?

    private var messageInputViewBottomConstant: CGFloat = 0 {
        didSet {
            guard let bottomConstraint = messageInputViewBottomLayoutConstraint else {
                return
            }
            bottomConstraint.constant = messageInputViewBottomConstant
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }

    var expense: EXP_DTL? {
        didSet {
            guard let expense = expense else { return }
            titleView.title = "Expense Notes"
            if let expTypeDescription = expense.EXP_TYPE_DESCRIPTION {
                titleView.subtitle = expTypeDescription
            }
            if let notes = expense.NOTES {
                messageView.text = notes
            }
        }
    }

    var trip: EXP_HDR? {
        didSet {
            guard let trip = trip else { return }
            titleView.title = "Trip Notes"
            if let tripName = trip.TRIP_NAME {
                titleView.subtitle = tripName
            }
            if let notes = trip.NOTES {
                messageView.text = notes
            }
        }
    }

    let titleView: TitleView = {
        return TitleView("", subtitle: "")
    }()

    let messageView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.layer.borderColor = UIColor.clear.cgColor
        textView.font = UIFont(name: "HelveticaNeue", size: 16)
        textView.alwaysBounceVertical = true
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.contentInset = UIEdgeInsets(
            top: 0,
            left: 20,
            bottom: 0,
            right: 20
        )
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    let messageInputView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue", size: 16)
        textView.layer.masksToBounds = true
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 30
        textView.backgroundColor = UIColor.accentGray
        textView.layer.borderColor = UIColor.placeholder.cgColor
        textView.isEditable = true
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        textView.sizeToFit()
        textView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
        textView.textContainerInset = UIEdgeInsets(
            top: 20,
            left: 20,
            bottom: 20,
            right: 70
        )
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        button.setTitleColor(UIColor.MainColors.lightColor, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(
            self,
            action: #selector(handleSend),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let border: Border = {
        return Border()
    }()

    lazy var closeNavbarItem: CloseNavbarButtonItem = {
        let navbarItem = CloseNavbarButtonItem()
        navbarItem.target = self
        navbarItem.action = #selector(close)
        return navbarItem
    }()

    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageInputView.becomeFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    fileprivate func setup() {
        view.backgroundColor = .white
        view.addSubview(titleView)
        view.addSubview(messageView)
        view.addSubview(border)
        view.addSubview(messageInputView)
        view.addSubview(sendButton)

        titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top).isActive = true
        titleView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        messageView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        messageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: messageInputView.topAnchor, constant: -10).isActive = true

        messageInputViewBottomLayoutConstraint = messageInputView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        messageInputViewBottomLayoutConstraint?.isActive = true
        messageInputView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        messageInputView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true

        sendButton.rightAnchor.constraint(equalTo: messageInputView.rightAnchor, constant: -20).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: messageInputView.bottomAnchor, constant: -15).isActive = true

        border.bottomAnchor.constraint(equalTo: messageInputView.topAnchor, constant: -10).isActive = true
        border.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        border.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        navigationItem.leftBarButtonItem = closeNavbarItem
    }

    @objc func handleSend() {
        guard let text = messageInputView.text else { return }
        CoreDataManager.shared.getCurrentUser { (coreUser, error) in
            guard let user = coreUser, let username = user.username else {
                self.presentAlert(title: "Error", message: error.localizedDescription)
                return
            }
            if let trip = trip, let id = trip.ID {
                DBManager.shared.sendTripNotes(id: id, username: username, notes: text) { (err) in
                    if err.code >= 300 {
                        self.presentAlert(title: "Error", message: err.localizedDescription)
                    }
                    if let delegate = self.delegate {
                        delegate.messageViewController(self, messageSent: text, tag: self.tag)
                    }
                    self.close()
                }
            }
            if let expense = expense, let id = expense.ID {
                DBManager.shared.sendTripNotes(id: id, username: username, notes: text) { (err) in
                    if err.code >= 300 {
                        self.presentAlert(title: "Error", message: err.localizedDescription)
                    }
                    if let delegate = self.delegate {
                        delegate.messageViewController(self, messageSent: text, tag: self.tag)
                    }
                    self.close()
                }
            }
        }
    }

    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            messageInputViewBottomConstant = -keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            messageInputViewBottomConstant = -20
        }
    }
}
