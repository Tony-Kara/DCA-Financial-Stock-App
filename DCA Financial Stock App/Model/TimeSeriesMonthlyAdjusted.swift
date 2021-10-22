//
//  TimeSeriesMonthlyAdjusted.swift
//  DCA Financial Stock App
//
//  Created by mac on 10/17/21.
//

import Foundation

struct MonthInfo {
    let date: Date
    let adjustedOpen: Double
    let adjustedClose: Double
}


struct TimeSeriesMonthlyAdjusted: Decodable {
    
    let meta: Meta
    let timeSeries: [String: OHLC]
    
    enum CodingKeys: String, CodingKey{
        case meta = "Meta Data"
        case timeSeries = "Monthly Adjusted Time Series"
    }
    
    
    func getMonthInfos() -> [MonthInfo] {
        var monthInfos: [MonthInfo] = []
       // sort out by dates, this will line up the results accordingly
        let sortedTimeSeries = timeSeries.sorted(by: {$0.key > $1.key})
        print("sorted: \(sortedTimeSeries)")
        return monthInfos
    }
}

struct Meta: Decodable {
    let symbol: String
    enum CodingKeys: String, CodingKey{
        case symbol = "2. Symbol"
    }
}

struct OHLC: Decodable{
    
    let open: String
    let close: String
    let adjustedClose: String
    
    enum CodingKeys: String, CodingKey{
        case open = "1. open"
        case close = "4. close"
        case adjustedClose = "5. adjusted close"
    }
}
