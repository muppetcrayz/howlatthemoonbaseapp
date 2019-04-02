//
//  Constants.swift
//  howlatthemoon
//
//  Created by Dan Turner on 3/3/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGFloat {
    static let standardiOSSpacing: CGFloat = 8.0
}

extension Double {
    static let standardiOSAnimationDuration: Double = 0.33
}

enum API {
    static let baseURL = "https://requestatthemoon.com"
    static let consumerKey = "ck_89cd5194afe9c715c2ad8583170f8d9d9ab8f2c1"
    static let consumerSecret = "cs_f871b1a3cd1cb88e6e7bc7a01f809d720add75fc"
    
    static func urlParameterStringFor(consumerKey: String, consumerSecret: String) -> String {
        return "consumer_key=\(consumerKey)&consumer_secret=\(consumerSecret)"
    }
    
    enum Categories {
        static let baseURL = "\(API.baseURL)/wp-json/wc/v3/products/categories"
        
        static let listURL = "\(baseURL)?\(urlParameterStringFor(consumerKey: consumerKey, consumerSecret: consumerSecret))&per_page=100"
    }
    
    enum Songs {
        static let baseURL = "\(API.baseURL)/wp-json/wc/v3/products"
        
        static func songURL(category: Int) -> String {
            return "\(baseURL)?\(urlParameterStringFor(consumerKey: consumerKey, consumerSecret: consumerSecret))&per_page=100&category=" + category.description
        }
        
        static func songURL(searchTerm: String) -> String {
            return "\(baseURL)?\(urlParameterStringFor(consumerKey: consumerKey, consumerSecret: consumerSecret))&per_page=100&search=" + searchTerm
        }
    }
    
    enum Transactions {
        // TODO: put location
        static let baseURL = "https://connect.squareup.com/v2/locations/CBASEPjYieIID0t4z7mgJmJI--kgAQ/transactions"
        
    }
    
    enum Orders {
        static let loadURL = "\(API.baseURL)/wp-json/wc/v2/orders?\(urlParameterStringFor(consumerKey: consumerKey, consumerSecret: consumerSecret))"
    }
}
