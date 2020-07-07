//
//  LoginSignupController.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/8/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    /* Creates Controller that alerts the user of their phone being in 'Battery Save Mode' */
    func batteryModeAlert() {
        let alert = UIAlertController(title: "Low Power Mode is ON",
                                      message: "Low Power Mode needs to be turned OFF to use this app. Would you like to turn it off?",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Turn OFF", style: .default, handler: handleOKAction)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)

        self.present(alert,
                     animated: true,
                     completion: nil)
    }

    func handleOKAction(action: UIAlertAction) {
        UIApplication.shared.open(URL(string: "App-Prefs:root=BATTERY")!,
                                  options: [:],
                                  completionHandler: nil)
    }
}

protocol AuthViewControllerDelegate {
    func authViewController(_ authViewController: AuthViewController, loggedIn model: SessionModel)
}

class AuthViewController: UIViewController, UIScrollViewDelegate {

    var delegate: AuthViewControllerDelegate?

    /* Global Variables */
    var loginButtonBottomConstraint: NSLayoutConstraint?
    var loginScrollViewHeightConstraint: NSLayoutConstraint?
    
    /* Controller Components */
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let amadaLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "amada_logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let loginScrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "HelveticaNeue-Medium", size: 21)
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.black
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(handleEmailField), for: .editingChanged)
        return textField
    }()
    
    let passwordField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.alphabet
        textField.font = UIFont(name: "HelveticaNeue-Medium", size: 21)
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.black
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(handlePasswordField), for: .editingChanged)
        return textField
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "USERNAME OR EMAIL"
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "PASSWORD"
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "right_arrow_white"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    let progressIndicator: ProgressIndicator = {
        let progressIndicator = ProgressIndicator(text: "Logging in...")
        return progressIndicator
    }()
    
    func enableLoginButton() {
        self.loginButton.alpha = 1.0
        self.loginButton.isEnabled = true
    }
    
    func disableLoginButton() {
        self.loginButton.alpha = 0.25
        self.loginButton.isEnabled = false
    }
    
    /* Controller LifeCycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setGradientBackground()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.disableLoginButton()
        self.initializeMainView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Set email design
        self.emailField.setBottomLine(borderColor: UIColor.black)
        self.passwordField.setBottomLine(borderColor: UIColor.black)
        self.lowerPowerModeCheck()
    }
    
    /* Check if user is on 'Lowe Power Mode' */
    func lowerPowerModeCheck() {
        if ProcessInfo.processInfo.isLowPowerModeEnabled {
            print("Low Power Mode Enabled.")
            self.batteryModeAlert()
        } else {
            self.emailField.becomeFirstResponder()
        }
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
    
    /* Initialize Views */
    func initializeMainView() {
        // Add Components to Controller's View
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.loginScrollView)
        self.loginScrollView.addSubview(self.amadaLogo)
        self.loginScrollView.addSubview(self.emailLabel)
        self.loginScrollView.addSubview(self.emailField)
        self.loginScrollView.addSubview(self.passwordLabel)
        self.loginScrollView.addSubview(self.passwordField)
        self.loginScrollView.addSubview(self.loginButton)

        view.addSubview(progressIndicator)
        
        let viewWidth = self.view.bounds.width - 50
        
        // MainView Constraints
        self.mainView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.mainView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.mainView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // LoginScrollView Constraints
        self.loginScrollView.leftAnchor.constraint(equalTo: self.mainView.leftAnchor).isActive = true
        self.loginScrollView.rightAnchor.constraint(equalTo: self.mainView.rightAnchor).isActive = true
        self.loginScrollView.topAnchor.constraint(equalTo: self.mainView.topAnchor).isActive = true
        self.loginScrollViewHeightConstraint = self.loginScrollView.heightAnchor.constraint(equalToConstant: self.view.bounds.height)
        self.loginScrollViewHeightConstraint?.isActive = true
        self.loginScrollView.delegate = self
        self.loginScrollView.contentSize = CGSize(width: self.view.bounds.width, height: 400)
        
        // AMADA Logo Constraints
        self.amadaLogo.topAnchor.constraint(equalTo: self.loginScrollView.topAnchor, constant: 135).isActive = true
        self.amadaLogo.heightAnchor.constraint(equalToConstant: 62).isActive = true
        self.amadaLogo.widthAnchor.constraint(equalToConstant: 180).isActive = true
        self.amadaLogo.leftAnchor.constraint(equalTo: self.loginScrollView.leftAnchor, constant: 25).isActive = true
        
        // Login Email Label Constraints
        self.emailLabel.topAnchor.constraint(equalTo: self.amadaLogo.bottomAnchor, constant: 40).isActive = true
        self.emailLabel.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor).isActive = true
        self.emailLabel.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        
        // Login Email Textfield Constraints
        self.emailField.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 5).isActive = true
        self.emailField.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        self.emailField.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor).isActive = true
        self.emailField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Login Password Label Constraints
        self.passwordLabel.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 10).isActive = true
        self.passwordLabel.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        self.passwordLabel.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor).isActive = true
        
        // Login Password Textfield Constraints
        self.passwordField.topAnchor.constraint(equalTo: self.passwordLabel.bottomAnchor, constant: 5).isActive = true
        self.passwordField.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        self.passwordField.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor).isActive = true
        self.passwordField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Login Button Constraints
        let loginButtonDimensions:CGFloat = 60
        self.loginButton.heightAnchor.constraint(equalToConstant: loginButtonDimensions).isActive = true
        self.loginButton.widthAnchor.constraint(equalToConstant: loginButtonDimensions).isActive = true
        self.loginButtonBottomConstraint = self.loginButton.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -25)
        self.loginButtonBottomConstraint?.isActive = true
        self.loginButton.rightAnchor.constraint(equalTo: self.mainView.rightAnchor, constant: -20).isActive = true
        self.loginButton.layer.cornerRadius = loginButtonDimensions / 2
    }
    
    /* UI Manip */
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    /* Sets top bar(where battery is displayed) to either white or black */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    /* Called as soon as user touches the screen */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /* Called as soon as user stopped touching screen */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}

    func login(email: String, password: String) {
        disableLoginButton()
        DBManager.shared.login(email: email, password: password) { (sessionModel, error) in
            guard let sessionModel = sessionModel else {
                self.enableLoginButton()
                self.presentAlert(title: "Error", message: error.localizedDescription)
                return
            }
            CoreDataManager.shared.saveUserSession(sessionModel: sessionModel) { (err) in
                self.dismiss(animated: true, completion: {
                    self.enableLoginButton()
                })
                if let delegate = self.delegate {
                    delegate.authViewController(self, loggedIn: sessionModel)
                }
            }
        }
    }
}

// POST: https://fieldapp.amada.com/API/Account/Login
//    func getUserLogin(email:String,password:String) {
//        let urlString = "http://fieldappdev.amada.com/API/Account/Login/?Email=" + email + "&Password=" + password
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if error != nil {
//                print("Error when getting data: \(error.debugDescription)")
//                return
//            }
//            if let data = data {
//                let raw = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//                print("Data: \(raw)")
//            }
//        }.resume()
//    }
/*

 func login(email: String, password: String) {
     disableLoginButton()
     guard let loginUrl: String = Bundle.main.object(forInfoDictionaryKey: "LOGIN_URL") as? String,
         let url = URL(string: "\(loginUrl)LoginGet/?Email=\(email)&Password=\(password)") else {
             enableLoginButton()
             return
     }

     let urlRequest = URLRequest(url: url)

     // setup the session
     let config = URLSessionConfiguration.default
     let session = URLSession(configuration: config)

     // make the request
     let task = session.dataTask(with: urlRequest) { (data, response, error) in
         guard error == nil, let data = data else {
             self.enableLoginButton()
             return
         }

         do {
             let session = try JSONDecoder().decode(SessionModel.self, from: data)
             CoreDataManager.shared.saveUserSession(sessionModel: session) { (err) in
                 if err.code >= 300 {
                         self.presentAlert(title: "Error", message: "Invalid Login Credentials")
                         self.enableLoginButton()
                         return
                 }
                 self.dismiss(animated: true, completion: {
                     self.enableLoginButton()
                 })
                 if let delegate = self.delegate {
                     delegate.authViewController(self, loggedIn: session)
                 }
             }
         } catch let err {
             print("error trying to convert data to json1x: \(err)")
             return
         }
     }
     task.resume()
 }

 */
