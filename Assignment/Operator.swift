//
//  Operator.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/11/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import Foundation
import SwiftyJSON


class Operator {
    static let instance = Operator()
    
    typealias ParserResponse = (data: Any? , error : Error?)
    typealias ImageResponse = (data: UIImage? , error : Error?)
    
    


    
    private func parseMovieImages (id : Int , completion : @escaping(ParserResponse)->()) {
        Network.request(urlRequest: .getImages(id: id)) { (data , error) in
            guard let d = data else {completion((nil , CustomError.networkError("A network error occured!"))) ; return}
            if let filePath = d[keys.posters].array?.first?.dictionaryObject?[keys.filePath] as? String {
                let poster = Poster(id: id, filePath: filePath)
                completion((poster , error))
            }
            else {
                completion((nil , CustomError.notFoundError("File path not found!")))
            }
            
            }
    }
    
    
    func parseSearchResult (name : String , page : Int , completion : @escaping(ParserResponse)->()) {
        
        Network.request(urlRequest: .searchMovie(name: name, page: page)) { (data , error) in
            guard let d = data , let dict = d.dictionaryObject else {completion((nil , CustomError.networkError("A network error occured!"))) ; return}
            if let page = dict[K.APIParameterKey.page] as? Int , let totalPages = dict[K.APIParameterKey.totalPages] as? Int , let totalResults = dict[K.APIParameterKey.totalResults] as? Int {
                if let results = dict[K.APIParameterKey.results] {
                    var movies : [Movie] = []
                    for m in JSON(results).array ?? [] {
                        if let mDict = m.dictionaryObject {
                            let movie = Movie(id:  mDict[K.APIParameterKey.id] as? Int ?? 0, title: mDict[K.APIParameterKey.title] as? String ?? "", poster: Poster(id: mDict[K.APIParameterKey.id] as? Int ?? 0, filePath: mDict[K.APIParameterKey.filePath] as? String ?? ""), overview: mDict[K.APIParameterKey.overview] as? String ?? "", releaseDate: mDict[K.APIParameterKey.releaseDate] as? String ?? "")
                            movies.append(movie)
                        }
                    }
                    let results = QueryResult(movies: movies, page: page, totalPages: totalPages, totalResults: totalResults)
                    completion((results , nil))
                    return
                }
            }
            else {
                completion((nil , CustomError.notFoundError("Page not found!")))
            }
            
        }
        
        
    }
    
    
    func getMoviePoster (size : PosterSize , poster : Poster ,  completion : @escaping(ImageResponse)->()) {
        parseMovieImages(id: poster.id) { (data , error) in
            guard let filePath = (data as? Poster)?.filePath else {completion((nil , error)) ; return}
            
            Network.requestImage(urlRequest: .getPoster(size: size.rawValue, path: filePath), completion: { (img , err) in
                guard let image = img else {completion((nil , err)); return}
                
                completion((image , nil))
            })
        }
    }
    
    
    
    
    
  
    

}
