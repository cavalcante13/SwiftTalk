//
//  Services.swift
//  SwiftTalk
//
//  Created by Diego Cavalcante on 15/08/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import Foundation

let itunesUrl = "https://ituness.apple.com/search?media=music&entity=song&term=Taylor"


public typealias JSON       = [String : Any]
public typealias JSONArray  = [[String : Any]]

struct NetworkingService<T> {
    let url     : String
    let parse   : ((Any) -> T?) 
    
    func load(completion : @escaping (T?)-> Swift.Void) {
        
        let url = URL(string: self.url)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            let json = data.flatMap{
                try? JSONSerialization.jsonObject(with: $0, options: [])
            }
            print(error)
            OperationQueue.main.addOperation {
                completion(error == nil ? json.flatMap(self.parse) : error.flatMap(self.parse))
            }
        }.resume()
    }
}
