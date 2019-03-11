//
//  APIRouter.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/10/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter : URLRequestConvertible {
    
    
    
    case searchMovie(name : String)
    case getPoster(size : String , path : String)
    case getImages(id : Int)
    
    
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
    
    private var path: String {
        switch self {
        case .searchMovie(_):
            return "/search/movie"
        case .getPoster(let size, let path) :
            return "/\(size)/\(path)"
        
        case .getImages(let id):
            return "/movie/\(id)/images"
        }
        
    }
    
    private var parameters: Parameters?  {
        switch self {
        case .searchMovie(let name):
            return [K.APIParameterKey.query : name]
        default :
            return [K.APIParameterKey.apiKey: K.APIKey]
        }
    }
    
    
    
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

extension Collection where Iterator.Element == [String:AnyObject] {
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        if let arr = self as? [[String:AnyObject]],
            let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
            let str = String(data: dat, encoding: String.Encoding.utf8) {
            return str
        }
        return "[]"
    }
}

