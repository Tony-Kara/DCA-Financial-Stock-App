//
//  Date+Extensions.swift
//  DCA Financial Stock App
//
//  Created by mac on 11/9/21.
//

import Foundation

extension Date {
    
    var MMYYFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
    
  
    
}
