//
//  Network.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/11/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON
import UIKit

class Network {
    /// a tuple for requests with a json response and corresponding error(if any).
    typealias RequestResponse = (data: JSON? , error:Error?)
    /// a tuple for requests with an image response and corresponding error(if any).
    typealias ImageResponse = (data: UIImage? , error : Error?)

    
    /**
     makes an alamofire request with a json response.
     
     - Parameters:
        - urlRequest: Desired API call.
        - completion: A completion handler with RequestResponse input.
    */
    
    static func request (urlRequest : APIRouter, completion : @escaping(RequestResponse)->()) {
        Alamofire.request(urlRequest).responseJSON { (response) in
            switch response.result {
            case .success(let result) :
                let json = JSON(result)
                let outputResponse:RequestResponse = (json , response.error)
                completion(outputResponse)
                
            case .failure(let error) :
                print("Alamofire Error : \(error.localizedDescription)")
                let outputResponse:RequestResponse = (nil, error)
                completion(outputResponse)

            }
            }
    }
    
    
    /**
     makes an alamofire request with a image response.
     
     - Parameters:
        - urlRequest: Desired API call.
        - completion: A completion handler with RequestResponse input.
     */
    static func requestImage (urlRequest : APIRouter, completion : @escaping(ImageResponse)->()) {
        Alamofire.request(urlRequest).responseImage { (response) in
            switch response.result {
            case .success(_) :
                
                if let img = response.result.value {
                    let outputResponse:ImageResponse = (img , response.error)
                    completion(outputResponse)
                }
                else {
                    let outputResponse:ImageResponse = (nil , response.error)
                    completion(outputResponse)
                }
                
            case .failure(let error) :
                print("Alamofire Error : \(error.localizedDescription)")
                let outputResponse:ImageResponse = (nil, error)
                completion(outputResponse)
                
            }
            
        }
    }
}
