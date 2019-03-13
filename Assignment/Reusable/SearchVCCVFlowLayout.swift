//
//  SearchVCCVFlowLayout.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/12/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit

class SearchVCCVFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let height = screenSize.height
        let width = screenSize.width
        self.itemSize = CGSize(width: width , height: height)
        self.scrollDirection = .vertical
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
