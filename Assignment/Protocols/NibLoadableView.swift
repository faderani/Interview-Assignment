//
//  NibLoadableView.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/11/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit

protocol NibLoadableView : class {
}

extension NibLoadableView where Self : UIView {
    static var nibName : String {
        return String(describing: self)
    }
}
