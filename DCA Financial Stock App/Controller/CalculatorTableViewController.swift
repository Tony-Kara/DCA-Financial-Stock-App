//
//  CalculatorTableViewController.swift
//  DCA Financial Stock App
//
//  Created by mac on 10/24/21.
//

import UIKit

class CalculatorTableViewController: UITableViewController {
    
    @IBOutlet weak var initialInvestmentAmountTextField: UITextField!
    @IBOutlet weak var montlyDollarCostAveragingTextField: UITextField!
    
    @IBOutlet weak var initialDateOfInvestment: UITextField!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet var currencyLabels: [UILabel]!
    @IBOutlet weak var investmentAmountCurrencyLabel: UILabel!
    
    var asset: Asset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTextFields()
    }
    
    
    func setupViews() {
        symbolLabel.text = asset?.searchResult.symbol
        NameLabel.text = asset?.searchResult.name
        investmentAmountCurrencyLabel.text = asset?.searchResult.currency
        currencyLabels.forEach { (label) in
            label.text = asset?.searchResult.currency.addBrackets()
        }
    }
    
    
    func  setupTextFields() {
        
        initialInvestmentAmountTextField.addDoneButton()
        montlyDollarCostAveragingTextField.addDoneButton()
        initialDateOfInvestment.delegate = self
        
    }
    
    
    
}


extension CalculatorTableViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == initialDateOfInvestment {
            performSegue(withIdentifier: "showDateSelection", sender: asset?.timeSeriesMonthlyAdusted)
        }
        
        
        return false // this ensures that this textfield is not editable
        
        
    }
}
