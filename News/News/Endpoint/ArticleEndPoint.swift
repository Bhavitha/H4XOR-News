//
//  ArticleEndPoint.swift
//  News
//
//  Created by Bhavitha on 22/03/22.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
}

enum ArticleAPI {
    case getNews
}

extension ArticleAPI: APIBuilder {

    var baseUrl: URL {
        switch self {
        case .getNews:
            return URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page")!
        }
    }

    var urlRequest: URLRequest {
        switch self {
        case .getNews:
            return URLRequest(url: self.baseUrl)
            
        }
    }
}
