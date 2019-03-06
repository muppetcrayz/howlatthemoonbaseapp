//
//  Product.swift
//  Bompe
//
//  Created by Sage Conger on 4/16/18.
//  Copyright © 2018 DUBTEL. All rights reserved.
//

import Foundation
import SwiftyJSON

class Song {
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
        var artist = ""
        if let attributes = dictionary["attributes"] as? [CategoryJSON] {
            let selection = attributes[0]
            let options = selection["options"] as! [String]
            artist = options[0]
        }
        self.name = dictionary["name"] as! String + "\n<i>" + artist + "</i>"
        
        if let images = dictionary["images"] as? [CategoryJSON] {
            let selection = images[0]
            self.image = selection["src"] as! String
        }
        else {
            self.image = ""
        }
        
    }
    
    func getSongPicture() -> UIImage {
        var pic: UIImage? = nil
        let web = URL(string: self.image)
        let data = try? Data(contentsOf: web!)
        if let imageData = data {
            pic = UIImage(data: imageData)
        }
        return pic!
    }
}
