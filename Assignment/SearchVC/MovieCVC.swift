//
//  MovieCVC.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/12/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit

class MovieCVC: ParentCVCell {
    @IBOutlet weak var overviewLbl : ReviewLbl!
    @IBOutlet weak var titleLbl : TitleLbl!
    @IBOutlet weak var releaseDateLbl : TitleLbl!
    @IBOutlet weak var poster : UIImageView!
    @IBOutlet weak var posterHeightConstraint: NSLayoutConstraint!
    
    func configureCell(movie : Movie , indexPath : IndexPath) {
        self.poster.image = nil
        _ = self.layer.sublayers?.contains(where: { (l) -> Bool in
            if l is CAGradientLayer {
                l.removeFromSuperlayer()
                return true
            }
            return false
        })
        if indexPath.row % 2 == 0 {
            let gradient = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = [UIColor.Label.grey.cgColor, UIColor.black.cgColor]
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
            self.layer.insertSublayer(gradient, at: 0)
        }
        else {
            let gradient = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = [UIColor.black.cgColor, UIColor.Label.grey.cgColor]
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
            self.layer.insertSublayer(gradient, at: 0)
        }
        if Int(String(movie.releaseDate.split(separator: "-").first!)) == 1992 {
            print(indexPath.row)
        }
        overviewLbl.text = movie.overview
        titleLbl.text = movie.title + " " + "(\(movie.releaseDate.split(separator: "-").first ?? ""))"
        Operator.instance.getMoviePoster(size: .large, poster: movie.poster, completion: {
            (image , err) in
            if let img = image {
                self.poster.image = img
            } else {
                
            }
            
        })
        
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
