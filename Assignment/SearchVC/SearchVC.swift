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
    private var queryResult : QueryResult?
    private var movies : [Movie] = []
    private var currentPage = 1
    private var flag = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reqFirstpage()
    }
    
    override func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCVC.self)
        collectionView.collectionViewLayout = SearchVCCVFlowLayout()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func reqFirstpage () {
        Operator.instance.parseSearchResult(name: query, page: currentPage) { (data , error) in
            guard let res = data as? QueryResult else {return}
            self.queryResult = res
            self.movies += self.queryResult?.movies ?? []
            self.collectionView.reloadData()
            self.flag = true
            self.currentPage += 1
            Operator.instance.saveToSearchHistory(query: self.query)
            
        }
    }
    
    func reqNextpage () {
        Operator.instance.parseSearchResult(name: query, page: currentPage) { (data , error) in
            guard let res = data as? QueryResult else {return}
            self.queryResult = res
            self.movies += self.queryResult?.movies ?? []
            self.collectionView.reloadData()
            self.flag = true
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
        
        return movies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(MovieCVC.self, indexPath: indexPath)
        cell.configureCell(movie : movies[indexPath.row] , indexPath : indexPath)
        
        
        if indexPath.row + 1 == (queryResult?.movies.count ?? 0) && currentPage + 1 != queryResult?.totalPages {
            flag = false
            reqNextpage()
        }
        return cell
    }
    
    
    
    
    
    
    
    
}
