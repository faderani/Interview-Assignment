//
//  QueryResult.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/12/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import Foundation

/// User's query result

struct QueryResult {
    /// movies found from the user's query.
    var movies : [Movie]
    /// page of current result. each page has a maximum of 20 movies.
    var page : Int
    /// total number of pages from user's query.
    var totalPages : Int
    /// total number of results from user's query = total number of movies.
    var totalResults : Int
}
