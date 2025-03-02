//
//  NewsAPIClient.swift
//  TCANewsApp
//
//  Created by Felix Anderson on 02/03/25.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct NewsAPIClient {
    var fetchAllNews: @Sendable () async throws -> [Article]
}

extension NewsAPIClient: DependencyKey {
    static let liveValue = NewsAPIClient(
        fetchAllNews: {
            let APIKEY = YOUR_API_KEY
            let urlString = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=\(APIKEY)"
            
            guard let newsUrl = URL(string: urlString) else { throw URLError(.badURL) }
            
            do {
                let userRequest = URLRequest(url: newsUrl)
                let (data, response) = try await URLSession.shared.data(for: userRequest)
                
                guard let newsData = try? JSONDecoder().decode(NewsResponse.self, from: data) else {
                    throw URLError(.cannotLoadFromNetwork)
                }
                /// (Optional) Clearing cache and cookies from previous URLSession
                await URLSession.shared.reset()
                return newsData.articles
            } catch {
                throw URLError(.cannotLoadFromNetwork)
            }
        }
    )
}

extension DependencyValues {
    var newsAPIClient: NewsAPIClient {
        get { self[NewsAPIClient.self] }
        set { self[NewsAPIClient.self] = newValue }
    }
}
