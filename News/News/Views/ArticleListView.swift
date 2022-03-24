//
//  ArticleListView.swift
//  News
//
//  Created by Bhavitha on 22/03/22.
//

import Foundation
import SwiftUI


struct ArticleListView: View {
    
    @Environment(\.openURL) var openURL
    @StateObject var viewModel: ArticleViewModel = ArticleViewModel(service: ArticleAPIService())

    @State private var alert: PopAlert?
    @EnvironmentObject var loginViewModel: LoginViewModel
 //   @ObservedObject var model: FirebaseDB
    
    @State var articles = [String]()
    
    var body: some View {
        
        Group {
            
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed:
                ErrorView()
            case .success(let content):
                NavigationView {
                    List(content) { article in
                        ArticleView(article: article)
                            .onTapGesture {
                                load(url: article.url)
                                FirebaseDB().save(value: "\(article.id)")
                            }
                       
                            .listRowBackground(articles.contains("\(article.id)") ? Color.gray : Color.white)
                           
                    }
                    
                    .alert(item: $alert) { value in
                        Alert(title: Text(value.title), message: Text(value.message), dismissButton: .default(Text("got it")) {
                            loginViewModel.isLoggedin = true
                            UserDefaults.standard.set(true, forKey: "isLoggedin")
                      })            }
                    .toolbar {
                        Button("Signout") {
                            signOut()
                        }
                    }
                  
                    .navigationBarTitle("H4XOR NEWS")
                }
            }
            
        }
        .onAppear {
            FirebaseDB().read { article in
                articles = article
            }
            self.viewModel.loadArticles()

        }
    }
        
    
    func load(url: String?) {
        guard let urlString = url,
              let  url = URL(string: urlString) else {
            return
        }
        openURL(url)
    }
    
    func signOut() {
        AuthManager.shared.signOut() { result in
            
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    alert = PopAlert(title: "signout", message: "signout success")
                }
            case .failure(_):
                DispatchQueue.main.async {
                    alert = PopAlert(title:"signout", message: "signout failed")
                }
            }
        }
    }

}
