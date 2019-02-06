//
//  BeerListViewController.swift
//  Beer Talk
//
//  Created by Matheus Queiroz on 2/5/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import UIKit

private let reuseIdentifier = "beerCell"

class BeerListViewController: UICollectionViewController {

    let r = RequestMaker()
    var model : BeerListViewModel?
    var isLoadingData: Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    var filteredBeers = [BeerModel]()
    
    @IBOutlet weak var beerLoadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerLoadingIndicator.startAnimating()
        beerLoadingIndicator.hidesWhenStopped = true
        
        setupSearchBar()
        
        model = BeerListViewModel(viewController: self)
        self.navigationItem.title = "Beers"
    }

    
    func setupSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Beers"
        self.navigationItem.searchController = searchController
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedCell = sender as! BeerCell
        let selectedCellIndexPath = self.collectionView.indexPath(for: selectedCell)
        let selectedBeer = model!.beersArray[selectedCellIndexPath!.row]
        
        let destinationViewController = segue.destination as! BeerDetailsViewController
        destinationViewController.selectedBeer = selectedBeer
    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(isFiltering()){
            return filteredBeers.count
        }
        return model?.beersArray.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BeerCell else {
            fatalError("Not a category cell")
        }
    
        var beerToSetup: BeerModel?
        if (isFiltering()) {
            beerToSetup = filteredBeers[indexPath.row]
        } else {
            beerToSetup = model?.beersArray[indexPath.row]
        }
        
        if(beerToSetup?.thumbnailPath != "Default" && !(beerToSetup?.isThumbnailLoaded)!){
            model?.loadImage(forBeer: beerToSetup!, completion: { (newThumbnail) in
                beerToSetup?.thumbnail = newThumbnail
                beerToSetup?.isThumbnailLoaded = true
                cell.setupForBeer(beerToSetup: beerToSetup!)
            })
        }
    
        cell.setupForBeer(beerToSetup: beerToSetup!)
        
        return cell
    }

    //MARK: Responding to model's request delegate
    
    func didLoadBeers(){
        self.collectionView.reloadData()
        self.isLoadingData = false
        self.beerLoadingIndicator.stopAnimating()
    }
    
    //MARK: Infinite Scroll
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        
        let diff = scrollContentSizeHeight - scrollOffset - scrollViewHeight    //This detects if the scroll is near the botom of the scroll view
        
        
        if (diff<30 && !isLoadingData)    //If the scroll is near the bottom, and there is no data being loaded, make a new request.
        {
            model?.requestMoreBeers()
            isLoadingData = true
        }
    }
    
    // MARK: - Search bar functions
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredBeers = (model?.beersArray.filter({( beer : BeerModel) -> Bool in
            return beer.name.lowercased().contains(searchText.lowercased())
        }))!
        collectionView.reloadData()
    }
}

extension BeerListViewController: UISearchResultsUpdating{
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
