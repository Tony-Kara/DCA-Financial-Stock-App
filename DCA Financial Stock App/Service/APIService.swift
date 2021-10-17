//
//  APIService.swift
//  DCA Financial Stock App
//
//  Created by mac on 8/18/21.
//

import Foundation
import Combine


struct APIService {
    // create a custom error for errors received after encoding the search querry keywords AND BAD REQUESTS below
    enum APIServiceError: Error{
        case encoding
        case badRequest
    }
    
    var apiKey: String {
        return keys.randomElement() ?? ""
    }
    
    let keys = ["L8CM1FUW5IR2862H" , "OX6AHYBLLGOACLSH" , "AUK1ANQD0HM9R6SQ"]
    
    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
        // use this to encode the keywords and replace all characters like empty space with a %20 to avoid errors
        guard let keywords = keywords.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else{return Fail(error: APIServiceError.encoding).eraseToAnyPublisher()}
        
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {return Fail(error: APIServiceError.badRequest).eraseToAnyPublisher()}
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
