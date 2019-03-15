//
//  APIRouter.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/10/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import Foundation
import Alamofire


/// Builds a request for each web service with all the necessary paramteres.
enum APIRouter : URLRequestConvertible {
    
    
    ///returns movies found based on the query.
    case searchMovie(name : String , page : Int)
    ///returns an image based on size and path.
    case getPoster(size : String , path : String)
    ///returns all the image pathes from movie's id.
    case getImages(id : Int)
    
    /// method used for the request. can be GET and POST and etc... .
    private var method: HTTPMethod {
        switch self {
        case .searchMovie(_):
            return .get
        case .getPoster(_,_):
            return .get
        case .getImages(_):
            return .get
        }
        
        
    }
    
    
    /// path for the request that is appended to the api production URL.
    private var path: String {
        switch self {
        case .searchMovie(_ , _):
            return "/search/movie"
        case .getPoster(let size, let path) :
            return "/\(size)/\(path)"
        
        case .getImages(let id):
            return "/movie/\(id)/images"
        }
        
    }
    
    /// request parameters
    private var parameters: Parameters?  {
        switch self {
        case .searchMovie(let name , let page):
            return [K.APIParameterKey.query : name , K.APIParameterKey.apiKey: K.APIKey , K.APIParameterKey.page: page]
        default :
            return [K.APIParameterKey.apiKey: K.APIKey]
        }
    }
    
    
    /**
     Initializes a URLRequest based on all the paramteres and prerequisites.
     
     - Returns: A complete URLRequest that needs no modification.
     - Throws: An AFError.invalidURL if self is not a valid URL string.
     */
    func asURLRequest() throws -> URLRequest {
        var u : URLComponents!
        
        switch self {
        case .getPoster(_ , _):
            u = URLComponents(url: try K.ProductionServer.baseImageURL.asURL().appendingPathComponent(path), resolvingAgainstBaseURL: true)
        default:
            u = URLComponents(url: try K.ProductionServer.baseURL.asURL().appendingPathComponent(path), resolvingAgainstBaseURL: true)
        }
        
        var urlRequest = URLRequest(url: u!.url!)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        switch self {
        case .getImages(_):
            urlRequest.setValue("image/jpeg", forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            urlRequest.setValue("image/jpeg", forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        default:
            break
        }
        
        // Parameters
        if let parameters = parameters {
            var items = [URLQueryItem]()
            for (key,value) in parameters {
                if let v = value as? String {
                    items.append(URLQueryItem(name: key, value: v))
                }
                else if let v = value as? Int {
                    items.append(URLQueryItem(name: key, value: String(v)))
                }
                else if let v = value as? Double {
                    items.append(URLQueryItem(name: key, value: String(v)))
                }
            }
            items = items.filter{!$0.name.isEmpty}
            if !items.isEmpty {
                u?.queryItems = items
            }
            urlRequest.url = u?.url
        }
        
        return urlRequest
    }
    
    
}

