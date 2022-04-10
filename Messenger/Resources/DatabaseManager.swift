//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Mike Chen on 4/9/22.
//

import Foundation
import FirebaseDatabase

//final means this class cannot be subclass
final class DatabaseManager {
    
    //want to create a singleton for an easy read and write access
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
//    public func test() {
//
//        database.child("foo").setValue(["something":true])
//    }
    
}

//MARK: - Account Management

extension DatabaseManager {//added extension for originize purpose
    
    //function to actually get data out of the database is a synchrounous so we need a completion block and this will be an add escaping completion block and return to us boolean
    //https://stackoverflow.com/questions/46245517/swift-escaping-and-completion-handler
    public func userExists(with email: String, completion: @escaping((Bool) -> Void)) { //bool based on validation passed, return true if email does not existed
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        //firebase database allows you to observe value changes on any entry in no sql database by specifying the child that what type of observation you want
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                //in the snapshot, if the value is a string
                completion(false)
                return
            }
            
            //passing completion handler true
            completion(true)
        })
        
    }
    ///inserts new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName,
            //no need for email one because upper there
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    //let profilePictureUrl: String
}
