//
//  PosterCell.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/11/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit

class PosterCell: ParentCell{

    @IBOutlet weak var img : UIImageView!
    
    func configureCell (img : UIImage) {
        self.img.image = img
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
