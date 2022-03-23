//
//  AuthManager.swift
//  News
//
//  Created by Bhavitha on 21/03/22.
//

import Foundation

class AuthManager {
    //protocol instance
    var authDelegate: AuthDelegate?
    static let shared = AuthManager(authDelegate: AuthFirebase())
    
    init(authDelegate: AuthDelegate) {
        self.authDelegate = authDelegate
    }
    func signIn(email: String, password: String,  completed response: @escaping (Result<Bool, AuthError>) -> Void) {
        self.authDelegate?.signIn(email: email, password: password, completed: response)
    }

    func signOut(completed response: @escaping (Result<Bool, NSError>) -> Void) {
        self.authDelegate?.signOut(completed: response)
    }

}
