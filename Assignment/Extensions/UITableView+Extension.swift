//
//  UITableView+Extension.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/11/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit

extension UITableView {
    func register <T: UITableViewCell> (_ : T.Type) where T : NibLoadableView {
        let nib = UINib (nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifire)
    }
    
    func dequeueReusableCell <T:UITableViewCell> (_ : T.Type ) -> T   {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifire) as? T else {
            fatalError("error creating a cell with identifire : \(T.reuseIdentifire)")
        }
        return cell
    }
}

extension UITableViewCell : ReuseableView {}

