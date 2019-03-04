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
    
    init() {
        self.id = 0
        self.name = ""
        self.image = ""
    }
    
    init?(dictionary: CategoryJSON) {
        self.id = dictionary["id"] as! Int
        self.name = dictionary["name"] as! String
        self.name = self.name.htmlDecoded
        
        if let image = dictionary["image"] as? CategoryJSON {
            self.image = image["src"] as! String
        }
        else {
            self.image = ""
        }
        
    }
    
    func getCategoryPicture() -> UIImage {
        var pic: UIImage? = nil
        let web = URL(string: self.image)
        let data = try? Data(contentsOf: web!)
        if let imageData = data {
            pic = UIImage(data: imageData)
        }
        return pic!
    }
}
