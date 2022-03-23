//
//  AuthDelegate.swift
//  News
//
//  Created by Bhavitha on 21/03/22.
//

import Foundation

protocol AuthDelegate {
    func signIn(email: String, password: String, completed: @escaping (Result<Bool, AuthError>) -> Void)
    func signOut(completed: @escaping (Result<Bool, NSError>) -> Void)
}
