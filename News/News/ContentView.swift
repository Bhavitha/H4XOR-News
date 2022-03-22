//
//  ContentView.swift
//  News
//
//  Created by Bhavitha on 22/03/22.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var loginViewModel: LoginViewModel
    var body: some View {
        NavigationView {
            if (loginViewModel.isLoggedin) as! Bool {
                LoginView()
            } else {
               ArticleListView()
            }
        }.accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
