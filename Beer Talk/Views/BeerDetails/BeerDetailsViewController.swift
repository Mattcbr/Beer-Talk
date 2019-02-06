//
//  BeerDetailsViewController.swift
//  Beer Talk
//
//  Created by Matheus Queiroz on 2/6/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import UIKit

class BeerDetailsViewController: UIViewController {

    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerTaglineLabel: UILabel!
    @IBOutlet weak var beerABVLabel: UILabel!
    @IBOutlet weak var beerIBULabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    
    var selectedBeer: BeerModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "\(selectedBeer!.name)"
        setupForSelectedBeer()
    }
    
    func setupForSelectedBeer(){
        beerImageView.image = selectedBeer?.thumbnail
        beerNameLabel.text = selectedBeer?.name
        beerTaglineLabel.text = selectedBeer?.tagline
        beerABVLabel.text = "Alcohol By Volume (ABV):\n\(selectedBeer!.abv)%"
        beerIBULabel.text = "Bitterness :\n\(selectedBeer!.ibu) (IBU)"
        beerDescriptionLabel.text = selectedBeer?.description
    }
}
