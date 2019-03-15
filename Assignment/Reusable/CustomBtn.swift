//
//  CustomBtn.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/12/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit

class CustomBtn: UIButton {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = false
        self.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 17)
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 3.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.9
        self.backgroundColor = UIColor.Btn.green
        self.setTitleColor(UIColor.Label.grey, for: .normal)
        self.alpha = 0.7
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
