//
//  AppSearchController.swift
//  AppStore Clone
//
//  Created by Harleen Singh on 26/01/21.
//

import UIKit
import SDWebImage


class AppSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    fileprivate let cellId = "cellID"
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview()
        setupSearchBar()
        
        //fetchITunesApps()
    }
    
    fileprivate func setupSearchBar() {
        
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            Service.shared.fetchApps(searchTerm: searchText) { (res, err) in
                self.appResults = res
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
        
        
        
    }
    
    
    
    fileprivate var appResults = [Result]()
    
    fileprivate func fetchITunesApps() {
        
        Service.shared.fetchApps(searchTerm: "Twitter") { (results,err)  in
            
            if let err = err {
                print("Failed to fetch apps: ", err)
                return
            }
            
            self.appResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = appResults.count != 0
        return appResults.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        
        cell.appResult = appResults[indexPath.item]
        
        
        return cell
    }
    
   
}
