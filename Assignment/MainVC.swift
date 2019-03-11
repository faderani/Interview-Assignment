//
//  MainVC.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/10/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainVC: ParentVC {
    
    @IBOutlet weak var collectionView : UICollectionView!
    var timr=Timer()
    var w:CGFloat=0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PosterCell.self)
        collectionView.collectionViewLayout = CVCustomFlowLayout()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configAutoscrollTimer()

    }
    
    func configAutoscrollTimer()
    {
        
        timr=Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(autoScrollView), userInfo: nil, repeats: true)
    }
    func deconfigAutoscrollTimer()
    {
        timr.invalidate()
        
    }
    func onTimer()
    {
        autoScrollView()
    }
    
    @objc func autoScrollView()
    {
        
        let initailPoint = CGPoint(x: w,y :-20)
        
        if __CGPointEqualToPoint(initailPoint, self.collectionView.contentOffset)
        {
            
            if w < collectionView.contentSize.width
            {
                w += 0.5
            }
            else
            {
                w = -self.view.frame.size.width
            }
            
            let offsetPoint = CGPoint(x: w,y :-20)
            
            collectionView.contentOffset = offsetPoint
            
        }
        else
        {
            w = collectionView.contentOffset.x
        }
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension MainVC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PosterCell.self, indexPath: indexPath)
        cell.configureCell()
       
        
        return cell
    
    }
    
    
}
