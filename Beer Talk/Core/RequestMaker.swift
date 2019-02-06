//
//  RequestMaker.swift
//  Beer Talk
//
//  Created by Matheus Queiroz on 2/5/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

protocol RequestDelegate: class{
    func didLoadBeers(beers:[BeerModel] )
    func didFailToLoadBeers(withError error: Error)
}

class RequestMaker {
    
    weak var delegate: RequestDelegate?
    let responseParser = Parser()
    
    func requestBeers(pageToRequest: Int) {
        let requestURL = "https://api.punkapi.com/v2/beers?page=\(pageToRequest)"
        
        Alamofire.request(requestURL).responseJSON{ response in
            switch response.result{
                
            case .success(let JSON):
                let beersArray = self.responseParser.parseBeers(response: JSON)
                self.delegate?.didLoadBeers(beers: beersArray)
            case .failure(let error):
                self.delegate?.didFailToLoadBeers(withError: error)
                print("Error:\(error.localizedDescription)")
            }
        }
    }
    
    func requestImage(imagePath: String, completion: @escaping (_ image: UIImage) -> Void) {
        Alamofire.request(imagePath).responseImage { response in
            if let image = response.result.value {
                completion(image)
            }
        }
}
}
