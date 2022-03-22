//
//  LoginViewModel.swift
//  News
//
//  Created by Bhavitha on 22/03/22.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var isLoggedin = UserDefaults.standard.value(forKey: "isLoggedin") ?? true
}
