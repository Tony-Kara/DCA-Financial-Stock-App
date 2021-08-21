//
//  SearchTableViewCell.swift
//  DCA Financial Stock App
//
//  Created by mac on 8/15/21.
//

import UIKit


class SearchTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet weak var assetSymbolLabel: UILabel!
    @IBOutlet weak var assetTypeLabel: UILabel!
    
    
    func configure(with searchResult: SearchResult) {
        assetNameLabel.text = searchResult.name
        assetSymbolLabel.text = searchResult.symbol
        assetTypeLabel.text  = searchResult.type.appending(" ").appending(searchResult.currency)
        
    }
    
}
