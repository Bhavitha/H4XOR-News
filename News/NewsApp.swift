//
//  NewsApp.swift
//  News
//
//  Created by Bhavitha on 21/03/22.
//

import SwiftUI
import Firebase

@main
struct NewsApp: App {
    
    @StateObject var loginViewModel = LoginViewModel()
    
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginViewModel)
        }
    }
}
