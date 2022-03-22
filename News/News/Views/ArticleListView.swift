//
//  ArticleListView.swift
//  News
//
//  Created by Bhavitha on 22/03/22.
//

import Foundation
import SwiftUI


struct ArticleListView: View {
    
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
                    }
                    .navigationBarTitle("H4XOR NEWS")
            }
        }
        .onAppear {
            self.viewModel.loadArticles()
        }
    }

}
