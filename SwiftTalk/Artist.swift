//
//  Artist.swift
//  SwiftTalk
//
//  Created by Diego Cavalcante on 15/08/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import Foundation


class Artist {
    var artistId        : Int?
    var trackId         : Int?
    var artistName      : String?
    var collectionName  : String?
    var artists         = [Artist]()
    
    init() {
        
    }
    
    init?(data : Any) {
        
        guard let json = data as? JSON,
            let jsonArray = json["results"] as? JSONArray else { return nil }
        
        for result in jsonArray {
            let artist = Artist()
            artist.artistId     = result["artistId"] as? Int
            artist.trackId      = result["trackId"] as? Int
            artist.artistName   = result["artistName"] as? String
            artist.collectionName = result["collectionName"] as? String
            
            artists.append(artist)
        }
    }
}
