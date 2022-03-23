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
    @ObservedObject var model = FirestoreViewModel()
    var selectedArticles = NSMutableDictionary()
    @State private var alert: PopAlert?
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        
        Group {
            
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ProgressView()
            case .success(let content):
                NavigationView {
                    List(content) { article in
                        ArticleView(article: article)
                            .onTapGesture {
                                load(url: article.url)
                                selectedArticles.setValue  ("\(article.id)", forKey: "id")
                                FirestoreViewModel().save(selectedNews: selectedArticles)
                            }
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
            self.viewModel.loadArticles()
           // FirestoreViewModel().loadVisitedArticles()
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
