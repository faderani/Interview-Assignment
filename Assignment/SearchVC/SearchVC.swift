//
//  SearchVC.swift
//  Assignment
//
//  Created by Soroush Shahi on 3/12/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import UIKit

class SearchVC: ParentVC {
    
    @IBOutlet weak var collectionView : UICollectionView!
    var query : String!
    var queryResult : QueryResult?
    var movies : [Movie] = []
    var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCVC.self)
        collectionView.collectionViewLayout = SearchVCCVFlowLayout()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reqNextpage()
    }
    
    func reqNextpage () {
        Operator.instance.parseSearchResult(name: query, page: currentPage) { (data , error) in
            guard let res = data as? QueryResult else {return}
            self.queryResult = res
            self.movies += self.queryResult?.movies ?? []
            self.collectionView.reloadData()
            self.currentPage += 1
            
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


extension SearchVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return queryResult?.movies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(MovieCVC.self, indexPath: indexPath)
        cell.configureCell(movie : queryResult!.movies[indexPath.row] , indexPath : indexPath)
        
        if indexPath.row == queryResult?.movies.count ?? 0 - 1 && currentPage != queryResult?.totalPages {
            reqNextpage()
        }
        return cell
    }
    
    
    
    
    
    
    
    
}
