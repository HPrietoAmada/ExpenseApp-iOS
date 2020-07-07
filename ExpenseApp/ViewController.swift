//
//  ViewController.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/8/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    /* Controller Components */
    let navbar: UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.barStyle = .default
        navbar.barTintColor = UIColor.clear
        navbar.backgroundColor = UIColor.clear
        navbar.tintColor = UIColor.black
        navbar.isTranslucent = true
        navbar.isOpaque = false
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        return navbar
    }()
    
    let navbarItems: UINavigationItem = {
        let navItems = UINavigationItem()
        navItems.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(handleNavbarCancel))
        return navItems
    }()
    
    @objc func handleNavbarCancel() {
        
    }
    
    let navbarBottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.tintColor = UIColor.white
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = UIColor.clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let titleView: TitleView = {
        let titleView = TitleView()
        titleView.titleTextView.text = "Title"
        titleView.subtitleTextView.text = "Subtitle"
        titleView.titleTextView.textContainer.maximumNumberOfLines = 2
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()
    
    /* Controller LifeCycle Methods */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navbar.setItems([self.navbarItems], animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initializeViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /* InitializeViews */
    func initializeViews() {
        self.view.addSubview(self.navbar)
        self.view.addSubview(self.navbarBottomBorder)
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.titleView)
        
        let viewWidth = self.view.bounds.width - 50
        
        // Navbar Constraints
        self.navbar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        self.navbar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.navbar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        // Navbar Bottom Border Constraints
        self.navbarBottomBorder.topAnchor.constraint(equalTo: self.navbar.bottomAnchor).isActive = true
        self.navbarBottomBorder.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.navbarBottomBorder.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.navbarBottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // ScrollView Constraints
        self.scrollView.topAnchor.constraint(equalTo: self.navbar.bottomAnchor).isActive = true
        self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.scrollView.contentSize = CGSize(width: self.view.bounds.width, height: 1000)
        self.scrollView.delegate = self
        
        // TitleView Constraints
        self.titleView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 50).isActive = true
        self.titleView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        self.titleView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
    }
    
    /* User began dragging ScrollView */
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.animateNavbarBorder(scrollView)
    }
    
    /* User stopped dragging ScrollView */
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.animateNavbarBorder(scrollView)
    }
    
    /* ScrollView stopped scrolling */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.animateNavbarBorder(scrollView)
    }
    
    /* Either shows or hides Navbar border depending on scrollView offset.y */
    func animateNavbarBorder(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y
        // Check if scrollView is at top
        if scrollOffset <= 0 {
            self.hideNavbarBottomBorder()
        } else {
            self.showNavbarBottomBorder()
        }
    }
    
    /* Animates the hiding of Navbar's top border */
    func hideNavbarBottomBorder() {
        self.navbarBottomBorder.backgroundColor = UIColor.clear
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    /* Animates the showing of Navbar's top border */
    func showNavbarBottomBorder() {
        self.navbarBottomBorder.backgroundColor = UIColor.MainColors.lightGray
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}

