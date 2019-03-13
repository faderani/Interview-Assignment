//
//  ReviewLbl.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/13/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit

class ReviewLbl: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: "Helvetica Neue", size: 17)
        self.minimumScaleFactor = 0.4
        self.textAlignment = .justified
        self.textColor = UIColor.white
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
