//
//  BeerCell.swift
//  Beer Talk
//
//  Created by Matheus Queiroz on 2/5/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import UIKit

class BeerCell: UICollectionViewCell {
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var alcoholPercentageLabel: UILabel!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    
    func setupForBeer(beerToSetup: BeerModel){
        imageLoadingIndicator.startAnimating()
        imageLoadingIndicator.hidesWhenStopped = true
        self.beerImageView.image = beerToSetup.thumbnail
        self.beerImageView.alpha = 0.6
        self.alcoholPercentageLabel.text = "\(beerToSetup.abv)% Alcohol"
        self.beerNameLabel.text = beerToSetup.name
    }
    
    func didFinishLoadingImage(beerToSetup: BeerModel){
        beerImageView.image = beerToSetup.thumbnail
        beerImageView.alpha = 1
        imageLoadingIndicator.stopAnimating()
    }
}
