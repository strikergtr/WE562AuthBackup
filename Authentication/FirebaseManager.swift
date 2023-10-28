//
//  FirebaseManager.swift
//  Authentication
//
//  Created by Instructor on 21/10/2566 BE.
//

import Foundation
import FirebaseAuth
import UIKit

class FirebaseManager {
    
    func register(email: String, password: String, completionBlock: @escaping(_ success: Bool) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) {authResult, error in
            if let user = authResult?.user {
                print(user)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    func login(email: String, password: String, completionBlock: @escaping(_ success: Bool) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
            if let foundError = error
            {
                _ = foundError as NSError
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
}
