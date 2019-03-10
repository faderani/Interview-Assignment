//
//  ReusableView.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/11/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import Foundation

import UIKit

protocol ReuseableView: class {
}

extension ReuseableView where Self : UIView {
    static var reuseIdentifire : String {
        return String(describing: self)
    }
}
