//
//  Article.swift
//  News
//
//  Created by Bhavitha on 22/03/22.
//

import Foundation

struct Article : Codable {
    let hits : [Hits]?
    let nbHits : Int?
    let page : Int?
    let nbPages : Int?
    let hitsPerPage : Int?
    let exhaustiveNbHits : Bool?
    let exhaustiveTypo : Bool?
    let query : String?
    let params : String?
    let processingTimeMS : Int?
}

struct Hits : Codable, Identifiable {
    let id: UUID = UUID()
    let created_at : String?
    let title : String?
    let url : String?
    let author : String?
    let points : Int?
    let story_text : String?
    let comment_text : String?
    let num_comments : Int?
    let story_id : String?
    let story_title : String?
    let story_url : String?
    let parent_id : String?
    let created_at_i : Int?
    let _tags : [String]?
    let objectID : String?
    let _highlightResult : _highlightResult?
    
    enum CodingKeys: String, CodingKey {

        case created_at = "created_at"
        case title = "title"
        case url = "url"
        case author = "author"
        case points = "points"
        case story_text = "story_text"
        case comment_text = "comment_text"
        case num_comments = "num_comments"
        case story_id = "story_id"
        case story_title = "story_title"
        case story_url = "story_url"
        case parent_id = "parent_id"
        case created_at_i = "created_at_i"
        case _tags = "_tags"
        case objectID = "objectID"
        case _highlightResult = "_highlightResult"
    }}

struct _highlightResult : Codable {
    let title : Title?
    let url : Url?
    let author : Author?
}

struct Author : Codable {
    let value : String?
    let matchLevel : String?
    let matchedWords : [String]?
}

struct Title : Codable {
    let value : String?
    let matchLevel : String?
    let matchedWords : [String]?
}

struct Url : Codable {
    let value : String?
    let matchLevel : String?
    let matchedWords : [String]?
}
