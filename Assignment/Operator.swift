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
    
    var defaults = UserDefaults.standard

    
    typealias ParserResponse = (data: Any? , error : Error?)
    typealias ImageResponse = (data: UIImage? , error : Error?)

    /// parses the movie's image pathes into a Poster class.
    ///
    /// - Parameters:
    ///     - id: id of the image.
    ///     - completion: completion handler with a ParserResponse input.
    private func parseMovieImages (id : Int , completion : @escaping(ParserResponse)->()) {
        Network.request(urlRequest: .getImages(id: id)) { (data , error) in
            guard let d = data else {
                self.showAlert(message: error?.localizedDescription ?? FailMessages.network , type: .retry) {
                    //self.parseMovieImages(id: id, completion: completion)
                }
                completion((nil , error)) ; return}
            if let filePath = d[keys.posters].array?.first?.dictionaryObject?[keys.filePath] as? String {
                let poster = Poster(id: id, filePath: filePath)
                completion((poster , error))
            }
            else {
                completion((nil , CustomError.notFoundError("File path not found!")))
            }
            
            }
    }
    
    /// parses the query's result into a QueryResult class.
    ///
    /// - Parameters:
    ///     - name: query's text.
    ///     - completion: completion handler with a ParserResponse input.
    func parseSearchResult (name : String , page : Int , completion : @escaping(ParserResponse)->()) {
        
        Network.request(urlRequest: .searchMovie(name: name, page: page)) { (data , error) in
            guard let d = data , let dict = d.dictionaryObject else {
                self.showAlert(message: error?.localizedDescription ?? FailMessages.network , type: .retry) {
                    self.parseSearchResult(name: name, page: page, completion: completion)
                }
                completion((nil , CustomError.networkError("A network error occured!"))) ; return}
            if let page = dict[K.APIParameterKey.page] as? Int , let totalPages = dict[K.APIParameterKey.totalPages] as? Int , let totalResults = dict[K.APIParameterKey.totalResults] as? Int {
                if let results = dict[K.APIParameterKey.results] {
                    var movies : [Movie] = []
                    for m in JSON(results).array ?? [] {
                        if let mDict = m.dictionaryObject {
                            let movie = Movie(id:  mDict[K.APIParameterKey.id] as? Int ?? 0, title: mDict[K.APIParameterKey.title] as? String ?? "", poster: Poster(id: mDict[K.APIParameterKey.id] as? Int ?? 0, filePath: mDict[K.APIParameterKey.filePath] as? String ?? ""), overview: mDict[K.APIParameterKey.overview] as? String ?? "", releaseDate: mDict[K.APIParameterKey.releaseDate] as? String ?? "")
                            movies.append(movie)
                        }
                    }
                    if movies.count == 0 {
                        self.showAlert(message: error?.localizedDescription ?? FailMessages.noResult , type: .backward) {
                        }
                        completion((nil , CustomError.notFoundError("no result!")))
                        return
                    }
                    let results = QueryResult(movies: movies, page: page, totalPages: totalPages, totalResults: totalResults)
                    completion((results , nil))
                    return
                }
                else {
                    
                    
                    
                }
            }
            else {
                self.showAlert(message: error?.localizedDescription ?? FailMessages.wrong , type: .backward) {
                }
                completion((nil , CustomError.notFoundError("Page not found!")))
            }
            
        }
        
        
    }
    
    /// gives the movie's poster UIImage.
    ///
    /// - Parameters:
    ///     - size: size of the image.
    ///     - poster: the poster which you want its image.
    ///     - completion: handler with an Imageresponse input.
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

extension Operator {
    /// will save the user's searched text.
    ///
    /// - Parameters:
    ///     - query: user's searched text.
    func saveToSearchHistory (query : String!) {
        if var array = defaults.stringArray(forKey: UserDefaultsKeys.queries) {
            if array.count == 10 {
                array.remove(at: 9)
            }
            array.insert(query, at: 0)
            array = Array(Set(array))
            defaults.set(array, forKey: UserDefaultsKeys.queries)
        }
        else {
            defaults.set([query], forKey: UserDefaultsKeys.queries)
        }
    }
    
    
    /// Returns the recovered saved user's searched text.
    func getRecentQueries () -> [String]? {
        let defaults = UserDefaults.standard
        let array = defaults.stringArray(forKey: UserDefaultsKeys.queries)
        return array
    }
    
    /// shows an alert on the toppest view controller.
    ///
    /// - Parameters:
    ///     - message: message of the alert.
    ///     - type: alert's type
    ///     - handler: the handler which will be called once the action button wil be pressed.
    private func showAlert(message : String , type : AlertType , handler : @escaping () -> Void) {
        switch type {
        case .retry:
            let vc = Operator.instance.getVisibleVC()
            
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Retry", style: .default) { (alert) in
                handler()
            }
            alert.addAction(action)
            vc.present(alert, animated: true, completion: nil)
            
            
        case .dismiss:
            let vc = Operator.instance.getVisibleVC()
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Retry", style: .default) { (alert) in
                handler()
            }
            alert.addAction(action)
            vc.present(alert, animated: true, completion: nil)
            
        case .backward:
            let vc = Operator.instance.getVisibleVC()
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Go back", style: .default) { (alert) in
                vc.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            vc.present(alert, animated: true, completion: nil)
            
        }
    }
    
    /// Returns the toppest viewcontroller in case we used a UINavigationController as the root.
    private func getVisibleVC () -> UIViewController {
        
        if let vc = getTopViewController() as? UINavigationController {
            return vc.topViewController!
        }
        
        return UIViewController()
    }
    
    /// Returns the toppest viewcontroller in case we didn't use a UINavigationController as the root.
    private func getTopViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
