//
//  BeerModel.swift
//  Beer Talk
//
//  Created by Matheus Queiroz on 2/5/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation
import UIKit

class BeerModel {
    let thumbnailPath : String
    var thumbnail : UIImage
    var isThumbnailLoaded : Bool
    let name : String
    let tagline : String
    let abv : Double
    let ibu : Double
    let description : String
    
    
    init(thpath: String, receivedName: String, Tag: String, receivedAbv: Double, receivedIbu: Double, desc: String) {
        self.thumbnailPath = thpath
        self.thumbnail = UIImage(named: "placeholder")!
        self.isThumbnailLoaded = false
        self.name = receivedName
        self.tagline = Tag
        self.abv = receivedAbv
        self.ibu = receivedIbu
        self.description = desc
    }
}
