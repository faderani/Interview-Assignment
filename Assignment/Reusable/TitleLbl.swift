//
//  CustomLbl.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/13/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit

class TitleLbl: UILabel {

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        self.minimumScaleFactor = 0.5
        self.textColor = UIColor.white
        self.addBorder(edges: .top, color: UIColor.white, thickness: 1.5)
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
