//
//  DataSource.swift
//  Bompe
//
//  Created by Sage Conger on 4/16/18.
//  Copyright © 2018 DUBTEL. All rights reserved.
//

import Foundation
import UIKit

final class DataStore {
    
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    var categories: [SongCategory] = []
    
    func getCategories(url: String, completion: @escaping () -> Void) {
        
        APIClient.getCategories(url: url) { (json) in
            if let results = json {
                for dict in results {
                    if let newCategory = SongCategory(dictionary: dict) {
                        if (newCategory.name != "Uncategorized") {
                            // add product if it is valid (ex. price exists) q
                            self.categories.append(newCategory)
                        }
                    }
                }
                completion()
            }
        }
    }
}
