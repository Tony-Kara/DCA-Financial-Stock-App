//
//  SearchResults.swift
//  DCA Financial Stock App
//
//  Created by mac on 8/18/21.
//

import Foundation


struct SearchResults : Decodable {
                    // The bestMatches contains an array of objects which needs to be created and accessed
                    // using bestMatches[0].name as example
    let bestMatches : [SearchResult]
}

struct SearchResult : Decodable {
    
    let symbol: String
    let name: String
    let type: String
    let currency: String
    
    
    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case currency = "8. currency"
            
    }
}
