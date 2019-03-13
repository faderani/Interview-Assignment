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
    
    @IBOutlet weak var collectionView : AutoScrollingCV!
    @IBOutlet weak var queryTF : CustomTF!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PosterCell.self)
        collectionView.collectionViewLayout = CVCustomFlowLayout()
        collectionView.configAutoscrollTimer()
        self.navigationController?.navigationBar.isHidden = true
        
        
        queryTF.delegate = self
        
        
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.configAutoscrollTimer()
        self.navigationController?.navigationBar.isHidden = true

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.isHidden = true

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        collectionView.deconfigAutoscrollTimer()
    }
    



    
    @IBAction func searchBtn(_sender : UIButton) {
        if queryTF.text == "" {
            return
        }
        let vc = SearchVC(nibName : "SearchVC" , bundle : nil)
        vc.query = queryTF.text
        self.navigationController?.pushViewController(vc, animated: true)
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

extension MainVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        collectionView.superview?.blurTheView()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        collectionView.superview?.deBlurTheView()

    }
}
