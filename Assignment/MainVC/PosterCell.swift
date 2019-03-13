//
//  PosterCell.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/11/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit
import SwiftyJSON


class PosterCell: ParentCVCell{

    @IBOutlet weak var img : UIImageView!
    
    override func configureCell () {
        self.img.image = nil
        let poster = Poster(id: Int.random(in: 100...1000), filePath: "")
        
        Operator.instance.getMoviePoster(size: .small, poster: poster, completion: {
            (image , err) in
            if let img = image {
                self.img.image = img
            } else {
                self.configureCell()
            }
            
        })
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
