//
//  News.swift
//  TCANewsApp
//
//  Created by Felix Anderson on 02/03/25.
//

import Foundation

struct NewsResponse: Decodable, Equatable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable, Equatable, Hashable {
    let author: String
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
