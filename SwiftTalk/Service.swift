//
//  Services.swift
//  SwiftTalk
//
//  Created by Diego Cavalcante on 15/08/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import Foundation


public typealias JSON       = [String : Any]
public typealias JSONArray  = [[String : Any]]

let itunesUrl = "https://itunes.apple.com/search?media=music&entity=song&term=Taylor"

struct Service<T> {
    let url     : String
    let parse   : ((Any) -> T?) 
    
    
    func load(dispatchQueue : DispatchQueue = .main, completion : @escaping (T?)-> Swift.Void) {
        
        let url = URL(string: self.url)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            let json = data.flatMap{
                try? JSONSerialization.jsonObject(with: $0, options: [])
            }
            
            dispatchQueue.async {
                completion(json.flatMap(self.parse))
            }
        }.resume()
    }
    
}
