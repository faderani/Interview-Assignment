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
    typealias RequestResponse = (data: JSON? , error:Error?)
    typealias ImageResponse = (data: UIImage? , error : Error?)

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
