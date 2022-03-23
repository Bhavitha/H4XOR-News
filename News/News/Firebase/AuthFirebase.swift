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
               print("error during sign in | \(String(describing: error))")
                return
            }
            completed(.success(true))
        }
    }

    func signOut(completed: @escaping (Result<Bool, NSError>) -> Void) {
        do {
            try Auth.auth().signOut()
            completed(.success(true))
        } catch let signOutError as NSError {
            completed(.failure(signOutError))
        }
    }
}
