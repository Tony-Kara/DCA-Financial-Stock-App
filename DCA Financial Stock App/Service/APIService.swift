//
//  APIService.swift
//  DCA Financial Stock App
//
//  Created by mac on 8/18/21.
//

import Foundation
import Combine


struct APIService {
    
    var apiKey: String {
        return keys.randomElement() ?? ""
    }
    
    let keys = ["L8CM1FUW5IR2862H" , "OX6AHYBLLGOACLSH" , "AUK1ANQD0HM9R6SQ"]
    
    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
        
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(apiKey)"
    
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
