//
//  AuthManager.swift
//  Instagram
//
//  Created by Anudeep Patel on 08/11/20.
//

import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    // MARK: - public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool)->Void){
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                // create account
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    guard error == nil , authResult != nil else {
                        print("ok1")
                        completion(false)
                        return
                    }
                    // insert into db
                    DatabaseManager.shared.insertNewUser(email: email, username: username, uid: (authResult?.user.uid)!) { (success) in
                        if success {
                            print("saved")
                            completion(true)
                        }else {
                            print("failed")
                            completion(false)
                        }
                    }
                }
            }else {
                print("canCreate failed")
                completion(false)
            }
        }
        
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void){
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil , error == nil else {
                    print("invalid data")
                    completion(false)
                    return
                }
                completion(true)
            }
            
        }else if let username = username {
            //user name login
            print(username)
        }
    }
    
    public func logOutUser(completion:(Bool)->Void){
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }catch{
            print(error)
            completion(false)
            return
        }
    }
}
