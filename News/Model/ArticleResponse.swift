//
//  APIResponse.swift
//  News
//
//  Created by Pierpaolo Mariani on 09/11/22.
//

import Foundation

struct ArticleResponse: Codable {
    var articles: [Article]
    var status: String
}

class Article: Codable {
    var source: Source
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
}

struct Source: Codable {
    var name: String
}
