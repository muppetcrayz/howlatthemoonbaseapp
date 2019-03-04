//
//  Product.swift
//  Bompe
//
//  Created by Sage Conger on 4/16/18.
//  Copyright © 2018 DUBTEL. All rights reserved.
//

import Foundation
import SwiftyJSON

class SongCategory {
    var id: Int
    var name: String
    var image: String
    var price: Double
    
    init() {
        self.id = 0
        self.name = ""
        self.image = ""
        self.price = 0.0
    }
    
    init?(dictionary: CategoryJSON) {
        
    }
    
    func getProductPictures() -> UIImage {
        var pic: UIImage? = nil
        let web = URL(string: self.image)
        let data = try? Data(contentsOf: web!)
        if let imageData = data {
            pic = UIImage(data: imageData)
        }
        return pic!
    }
}
