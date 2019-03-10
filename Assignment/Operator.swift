//
//  Operator.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/11/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import Foundation


class Operator {
    static let instance = Operator()
    
    
    func generateRandomImages () {
        for i in 0...20 {
            Network.request(urlRequest: .getImages(id: i)) { (data , error) in
                guard let img = data else {return}
                
                
            }
        }
    }
    

}
