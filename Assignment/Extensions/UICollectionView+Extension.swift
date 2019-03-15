//
//  UICollectionView+Extension.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/11/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /**
     registers a cell that conforms to NibLoadableView protocol.
     By using this func, there is no need for a cell identifire. Identifire will be the class name.
     */
    func register<T: UICollectionViewCell>(_: T.Type) where T: NibLoadableView {
        
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifire)
    }
    /**
     deques a reusable cell that conforms to NibLoadableView protocol.
     By using this func, there is no need for a cell identifire. Identifire will be the class name.
     */
    func dequeueReusableCell<T: UICollectionViewCell>(_ : T.Type , indexPath : IndexPath) -> T  {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifire, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifire)")
            
        }
        
        
        //        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifire, for: indexPath as IndexPath) as? T else {
        //            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifire)")
        //        }
        
        return cell
    }
}

extension UICollectionViewCell : ReuseableView {}

