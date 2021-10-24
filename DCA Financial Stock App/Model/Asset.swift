//
//  Asset.swift
//  DCA Financial Stock App
//
//  Created by mac on 10/24/21.
//

import Foundation

struct Asset {
    // we need certain data to be passed into the calculator View, creating a seperate Model that has access to the properties in the other models is the goal here
    let searchResult: SearchResult
    let timeSeriesMonthlyAdusted: TimeSeriesMonthlyAdjusted
}
