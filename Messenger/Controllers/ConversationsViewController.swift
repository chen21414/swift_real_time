//
//  ViewController.swift
//  Messenger
//
//  Created by Mike Chen on 4/6/22.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        //DatabaseManager.shared.test()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //userDefaults are about anything you want to really save to disk
        //let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        //no longer needed

        validateAuth()
    
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            //if user is not logged in, we want to present the login view controller
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen //import after iOS 13
            present(nav, animated: false)
        }
    }

}

