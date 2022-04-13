//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Mike Chen on 4/7/22.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class ProfileViewController: UIViewController {
    
    //creating a log out button
    //IB a connection from an interface builder user interface component
    @IBOutlet var tableView: UITableView!
    
    let data = ["Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")// register
        tableView.delegate = self //related to below extension
        tableView.dataSource = self
        
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    //look at numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    //look at cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
    //look at didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //this actionSheet is to show confirm to log out? down bottom
        let actionSheet = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .actionSheet
        )
        
        actionSheet.addAction(UIAlertAction(title: "Log Out",
                                      style: .destructive,
                                      handler: {[weak self] _ in
            guard let strongSelf = self else {
                return
            }
            
            //log out facebook
            FBSDKLoginKit.LoginManager().logOut()
            
            do {
                try FirebaseAuth.Auth.auth().signOut()
                
                //if user is not logged in, we want to present the login view controller
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen //import after iOS 13
                strongSelf.present(nav, animated: true)
            }
            catch{
                print("Failed to log out")
            }
        }
                                     ))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil
                                           ))
        
        present(actionSheet, animated: true)
        
        
    }
}
