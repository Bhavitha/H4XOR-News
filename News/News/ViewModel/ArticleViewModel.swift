//
//  ArticleViewModel.swift
//  News
//
//  Created by Bhavitha on 22/03/22.
//

import Foundation
import Combine

protocol ArticleViewModelDelegate {
    
    func loadArticles()
}

enum ResultState {
    case loading
    case success(content: [Hits])
    case failed
}

class ArticleViewModel: ObservableObject, ArticleViewModelDelegate {
    
    private let service: ArticleAPIService
    private(set) var articles = [Hits]()
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var state: ResultState = .loading
   
    init(service: ArticleAPIService) {
        self.service = service        
    }
    
    func loadArticles() {
        self.state = .loading
        let cancellable = self.service.request(from: .getNews)
            .sink { (response) in
                switch response {
                case .failure(let error):
                    self.state = .failed
                case .finished:
                    self.state = .success(content: self.articles)
                }
            } receiveValue: { response in
                guard let articles =  response.hits  else {
                    return
                }
                self.articles = articles
            }
        self.cancellables.insert(cancellable)
    }    
}
