//
//  Parser.swift
//  Beer Talk
//
//  Created by Matheus Queiroz on 2/5/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation

class Parser {
    func parseBeers(response: Any) -> [BeerModel] {
        let JSONresponse = response as? [[String : Any]]
        
        var beersArray = [BeerModel] ()
        
        JSONresponse?.forEach{ beerInfo in
            
            let thumbnailPath = beerInfo["image_url"] as? String ?? "Default"
            let name = beerInfo["name"] as? String ?? "Default"
            let tagline = beerInfo["tagline"] as? String ?? "Default"
            let abv = beerInfo["abv"] as? Double ?? 1000.0
            let ibu = beerInfo["ibu"] as? Double ?? 1000.0
            let description = beerInfo["description"] as? String ?? "Default"
            
            let newBeer = BeerModel(thpath: thumbnailPath,
                                    receivedName: name,
                                    Tag: tagline,
                                    receivedAbv: abv,
                                    receivedIbu: ibu,
                                    desc: description)
            beersArray.append(newBeer)
        }
        return beersArray
    }
}
