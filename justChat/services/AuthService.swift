//
//  AuthService.swift
//  justChat
//
//  Created by Mohamed Zakaria on 5/26/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    static var instance = AuthService()
    
    
    func registerUser(withEmail email: String, andPasswrd password: String, userCreateComplete: @escaping (_ status: Bool, _ error: Error? ) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            guard let user = user else {
                userCreateComplete(false, error)
                return
            }
            
            let userData = ["provider": user.providerID, "email": user.email]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreateComplete(true, nil)
            
        }
    }
    
    func loginUser(withEmail email: String, withPassword password: String, userLogedInComplete: @escaping (_ stauts: Bool, _ error : Error?) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                
                userLogedInComplete(false, error)
                return
                
            }
 
            
            userLogedInComplete(true, nil)
        }
    }
}
