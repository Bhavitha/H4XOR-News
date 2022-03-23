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
    @State private var selectedRow: String?
    var selectedArticles = NSMutableDictionary()
    var body: some View {
        
        Group {
            
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ProgressView()
            case .success(let content):
                    List(content) { article in
                        ArticleView(article: article)
                            .onTapGesture {
                                selectedRow = article.objectID
                                load(url: article.url)
                                selectedArticles.setValue(article.points, forKey: "points")
                                selectedArticles.setValue(article.title, forKey: "title")
                                selectedArticles.setValue(article.url, forKey: "url")
                                FirestoreViewModel().save(selectedNews: selectedArticles)
                            }.listRowBackground(selectedRow == article.objectID ? Color.gray : Color.white)
                    }
                    .navigationBarTitle("H4XOR NEWS")
            }
        }
        .onAppear {
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

}
