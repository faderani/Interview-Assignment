//
//  MainVC.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/10/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit
import SwiftyJSON
import DropDown

class MainVC: ParentVC {
    
    @IBOutlet weak var collectionView : AutoScrollingCV!
    @IBOutlet weak var queryTF : CustomTF!
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var searchBtn : UIButton!
    
    @IBOutlet weak var stckTopConstraint: NSLayoutConstraint!
    
    private let dropDown = DropDown()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.configAutoscrollTimer()
        self.navigationController?.navigationBar.isHidden = true
        //self.queryTF.text = ""

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.isHidden = true

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        collectionView.deconfigAutoscrollTimer()
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            if let queries = Operator.instance.getRecentQueries() {
                let keyboardRectangle = keyboardFrame.cgRectValue
                if queries.count > 3 {
                    stckTopConstraint.constant = self.view.frame.height - keyboardRectangle.height - stackView.frame.height - 20
                    UIView.animate(withDuration: 1) {
                        self.view.layoutIfNeeded()
                    }
                }
                
                dropDown.anchorView = stackView
                dropDown.dataSource = queries
                dropDown.direction = .top
                dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
                dropDown.show()
                
            }
            
        }
    }
    
    
    override func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PosterCell.self)
        
        collectionView.collectionViewLayout = CVCustomFlowLayout()
        collectionView.configAutoscrollTimer()
        self.navigationController?.navigationBar.isHidden = true
        queryTF.delegate = self
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        dropDown.dismissMode = .automatic
        dropDown.backgroundColor = UIColor.DropDown.orange
        dropDown.textColor = UIColor.Label.grey
        dropDown.cellHeight = 40
        dropDown.textFont = UIFont(name: "HelveticaNeue-Italic", size: 15) ?? UIFont()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.queryTF.text = item
            self.searchBtn(_sender: nil)
        }

    }
    



    
    @IBAction func searchBtn(_sender : UIButton?) {
        if queryTF.text == "" {
            return
        }
        let vc = SearchVC(nibName : "SearchVC" , bundle : nil)
        vc.query = queryTF.text
        self.navigationController?.pushViewController(vc, animated: true)
    }

}



extension MainVC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PosterCell.self, indexPath: indexPath)
        cell.configureCell()
        return cell
    
    }
    
    
}

extension MainVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //collectionView.superview?.blurTheView()
        UIView.animate(withDuration: 0.3) {
            self.searchBtn.alpha = 1.0
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //collectionView.superview?.deBlurTheView()
        if textField.text == "" {
            UIView.animate(withDuration: 0.3) {
                self.searchBtn.alpha = 0.7
            }
        }
        
        if self.stckTopConstraint.constant != 200 {
            self.stckTopConstraint.constant = 200
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
}
