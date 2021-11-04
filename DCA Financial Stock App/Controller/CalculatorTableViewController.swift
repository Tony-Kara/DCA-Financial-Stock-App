//
//  CalculatorTableViewController.swift
//  DCA Financial Stock App
//
//  Created by mac on 10/24/21.
//

import UIKit

//This will be the detail view for each row of stock selected, at this point, i do not need a reusable cell as i will not be using an array to loop through various index of elements and insert them in each roll, here, i can just add label to the cell, add IBOutlets and pass the values from the SearchTableViewController which is the first VC, in here, there is no need to insert any of the tableview methods.
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
    
    // here, i filled in the IBOutlets with values passed from the first VC
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
        initialDateOfInvestment.delegate = self // I need access to the UITextFieldDelegate methods and i need to set this textfield as a delegate to report whatever changes happens to it to the class.
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { This also works and is code is smaller
//        if segue.identifier == "showDateSelection",
//        let dateselectionTableViewController = segue.destination as? DateSelectionTableviewController {
//            dateselectionTableViewController.timeSeriesMonthlyAdjusted = asset?.timeSeriesMonthlyAdusted
//        }
//    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDateSelection",
        let dateselectionTableViewController = segue.destination as? DateSelectionTableviewController,
        let timeSeriesMonthlyAdusted = sender as? TimeSeriesMonthlyAdjusted
        {
            dateselectionTableViewController.timeSeriesMonthlyAdjusted = timeSeriesMonthlyAdusted
        }
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
