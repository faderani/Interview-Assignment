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
        static let APIVersion = "2"
        static let baseURL = "https://api.themoviedb.org/3"
    }
    
    struct APIParameterKey {
        static let query = "query"
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
