//
//  Constants.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/10/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import Foundation



struct K {
    
    static let APIKey = "29aa456b7e247127a10090970eea9de2"
    struct ProductionServer {
        static let baseURL = "https://api.themoviedb.org/3"
        static let baseImageURL = "https://image.tmdb.org/t/p"
    }
    
    struct APIParameterKey {
        static let query = "query"
        static let apiKey = "api_key"
        static let filePath = "file_path"
        static let posters = "posters"
        static let page = "page"
        static let totalPages = "total_pages"
        static let totalResults = "total_results"
        static let results = "results"
        static let id = "id"
        static let title = "title"
        static let overview = "overview"
        static let releaseDate = "release_date"
        static let posterPath = "poster_path"
    }
    
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}


enum CustomError: Error {
    case notFoundError(String)
    case networkError(String)
}


enum PosterSize: String {
    case small = "w185"
    case large = "w780"
}
