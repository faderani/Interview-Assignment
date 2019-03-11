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
    
    
    func getMoviePoster (poster : Poster ,  completion : @escaping(ImageResponse)->()) {
        parseMovieImages(id: poster.id) { (data , error) in
            guard let filePath = (data as? Poster)?.filePath else {completion((nil , error)) ; return}
            
            Network.requestImage(urlRequest: .getPoster(size: "w185", path: filePath), completion: { (img , err) in
                guard let image = img else {completion((nil , err)); return}
                
                completion((image , nil))
            })
            
            
        }
        
        
    }
    
    
    
  
    

}
