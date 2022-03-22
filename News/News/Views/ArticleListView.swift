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
                                load(url: article.url)
                            }
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
