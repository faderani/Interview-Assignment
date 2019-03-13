//
//  AutoScrollingCV.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/11/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit

class AutoScrollingCV: UICollectionView {
    


    private var timr=Timer()
    private var w:CGFloat=0.0
    
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.red
    }
    
    

    
    func configAutoscrollTimer()
    {
        self.isUserInteractionEnabled = false
        timr = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(autoScrollView), userInfo: nil, repeats: true)
    }
    func deconfigAutoscrollTimer()
    {
        timr.invalidate()
        
    }
    private func onTimer()
    {
        autoScrollView()
    }
    
    @objc private func autoScrollView()
    {
        
        let initailPoint = CGPoint(x: w,y :0)
        
        if __CGPointEqualToPoint(initailPoint, self.contentOffset)
        {
            
            if w < self.contentSize.width
            {
                w += 0.5
            }
            else
            {
                w = -1 * (self.superview?.frame.size.width ?? 0)
            }
            
            let offsetPoint = CGPoint(x: w,y :0)
            
            self.contentOffset = offsetPoint
            
        }
        else
        {
            w = self.contentOffset.x
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
