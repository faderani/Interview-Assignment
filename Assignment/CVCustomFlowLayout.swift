//
//  CVCustomFlowLayout.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/11/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit

class CVCustomFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let height = screenSize.height / 3 - 8
        self.itemSize = CGSize(width: height / 1.8 , height: height)
        self.scrollDirection = .horizontal
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
