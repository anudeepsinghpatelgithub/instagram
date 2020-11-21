//
//  DataManager.swift
//  Instagram
//
//  Created by Anudeep Patel on 08/11/20.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()

    // MARK: - public
    /// Check if user and email available
    public func canCreateNewUser(with email: String, username: String, completion:(Bool)->Void){
        completion(true)
    }
    // MARK: - public
    /// insert user into data
    public func insertNewUser(email: String, username: String, uid:String, completion: @escaping (Bool)->Void){
        database.child(Constants.userTable).child(uid).setValue(["username":username,"email":email]) { error, snapshot in
            if error == nil {
                print("ok5")
                completion(true)
                return
            }else {
                print("ok6")
                completion(false)
                return
            }
        }
    }
}
