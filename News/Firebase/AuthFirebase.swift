//
//  AuthFirebase.swift
//  News
//
//  Created by Bhavitha on 21/03/22.
//

import Foundation
import Firebase


public class AuthFirebase: AuthDelegate {
    
    func signIn(email: String, password: String,  completed: @escaping (Result<Bool, AuthError>) -> Void)  {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard let _ = error else {
                completed(.failure(.invalidData))
               // AppLogger.shared.error("error during sign in | \(String(describing: error))", module: AppLogger.Module.SHAPA)
                return
            }
            completed(.success(true))
           // AppLogger.shared.info("sign in success", module: AppLogger.Module.SHAPA)
            
        }
    }
    
    func forgotPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error == nil {
                
            }
        }
    }
    
    func signOut(completed: @escaping (Result<Bool, NSError>) -> Void) {
        do {
            try Auth.auth().signOut()
            completed(.success(true))
          //  AppLogger.shared.info("sign out success", module: AppLogger.Module.SHAPA)
        } catch let signOutError as NSError {
            completed(.failure(signOutError))
         //   AppLogger.shared.error("error while signing out", module: AppLogger.Module.SHAPA)
        }
    }
    
    func signUp(email: String, password: String, completed: @escaping (Result<Bool, AuthError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let _ = authResult?.user {
                completed(.success(true))
              //  AppLogger.shared.info("sign up success", module: AppLogger.Module.SHAPA)
            } else {
                completed(.failure(.signupError))
              //  AppLogger.shared.error("error while signup", module: AppLogger.Module.SHAPA)
            }
        }
    }
}
