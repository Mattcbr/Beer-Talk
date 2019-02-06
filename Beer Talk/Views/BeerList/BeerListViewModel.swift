//
//  BeerListViewModel.swift
//  Beer Talk
//
//  Created by Matheus Queiroz on 2/5/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation
import UIKit

class BeerListViewModel: RequestDelegate {
    let requestHandler = RequestMaker()
    var controller: BeerListViewController
    var beersArray = [BeerModel]()
    var pageToRequest: Int = 1
    
    init(viewController: BeerListViewController){
        controller = viewController
        
        requestHandler.delegate = self
        requestHandler.requestBeers(pageToRequest: pageToRequest)
        controller.isLoadingData = true
    }
    
    func didLoadBeers(beers: [BeerModel]) {
        if(beersArray.count == 0){
            beersArray = beers
        } else {
            beersArray.append(contentsOf: beers)
        }
        controller.didLoadBeers()
    }
    
    func didFailToLoadBeers(withError error: Error) {
        controller.loadingBeersFailed()
    }
    
    func loadImage(forBeer beer:BeerModel, completion: @escaping (_ image: UIImage) -> Void){
        requestHandler.requestImage(imagePath: beer.thumbnailPath) { (newThumbnail) in
            completion(newThumbnail)
        }
    }
    
    func requestMoreBeers() {
        pageToRequest = pageToRequest + 1
        self.requestHandler.requestBeers(pageToRequest: pageToRequest)
    }
}
