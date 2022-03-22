//
//  ArticleService.swift
//  News
//
//  Created by Bhavitha on 22/03/22.
//

import Foundation
import Combine

protocol ArticleAPIServiceDelegate {
    func request(from endpoint: ArticleAPI) -> AnyPublisher<Article, APIError>
}

class ArticleAPIService: ArticleAPIServiceDelegate {
    
    private var cancellables = Set<AnyCancellable>()
    
    func request(from endpoint: ArticleAPI) -> AnyPublisher<Article, APIError> {
    
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<Article, APIError> in

                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown)
                            .eraseToAnyPublisher()
                }

                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: Article.self, decoder: jsonDecoder)
                        .mapError {_ in .decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: .errorCode(response.statusCode))
                            .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
        
                         
    }
    
    
    
    
}
