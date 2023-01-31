//
//  Article.swift
//  NewsApp
//
//  Created by Giap on 31/01/2023.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String?
    let description: String?
}
