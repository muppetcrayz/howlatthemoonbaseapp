//
//  APIClient.swift
//  Bompe
//
//  Created by Sage Conger on 4/16/18.
//  Copyright © 2018 DUBTEL. All rights reserved.
//

import Foundation

typealias CategoryJSON = [String: Any]

struct APIClient {
    
    static func getCategories(url: String, completion: @escaping ([CategoryJSON]?) -> Void) {
        
        let url = URL(string: url)
        
        let session = URLSession.shared
        
        guard let unwrappedURL = url else { print("Error unwrapping URL"); return }
        
        let dataTask = session.dataTask(with: unwrappedURL) { (data, response, error) in
            
            guard let unwrappedData = data else { print("Error unwrapping data"); return }
            
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? [CategoryJSON]
                completion(responseJSON)
            } catch {
                print("Could not get API data. \(error), \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
    static func getSongs(url: String, completion: @escaping ([CategoryJSON]?) -> Void) {
        
        let url = URL(string: url)
        
        let session = URLSession.shared
        
        guard let unwrappedURL = url else { print("Error unwrapping URL"); return }
        
        let dataTask = session.dataTask(with: unwrappedURL) { (data, response, error) in
            
            guard let unwrappedData = data else { print("Error unwrapping data"); return }
            
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? [CategoryJSON]
                completion(responseJSON)
            } catch {
                print("Could not get API data. \(error), \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}
