//
//  CalculatorTableViewController.swift
//  DCA Financial Stock App
//
//  Created by mac on 10/24/21.
//

import UIKit

class CalculatorTableViewController: UITableViewController {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet var currencyLabels: [UILabel]!
    
    var asset: Asset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    
    func setupViews() {
        symbolLabel.text = asset?.searchResult.symbol
        NameLabel.text = asset?.searchResult.name
        currencyLabels.forEach { (label) in
            label.text = asset?.searchResult.currency.addBrackets()
        }
    }
    
}
