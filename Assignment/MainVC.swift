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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PosterCell.self)
        collectionView.collectionViewLayout = CVCustomFlowLayout()
        self.navigationController?.navigationBar.isHidden = true
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PosterCell.self, indexPath: indexPath)
        
        Network.request(urlRequest: .getImages(id: indexPath.row + 99)) { (data , error) in
            guard let d = data as? JSON else {return}
            
            let poster = d[keys.posters].array?.first?.dictionaryObject
            if let path = poster?[keys.filePath] as? String {
                
                Network.requestImage(urlRequest: .getPoster(size: "w185", path: path), completion: { (img , error) in
                    if let image = img as? UIImage {
                        cell.configureCell(img: image)

                    }
                })
            }
            
            
        }
        
        return cell
    
    }
    
    
}
