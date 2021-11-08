//
//  DateSelectionTableviewController.swift
//  DCA Financial Stock App
//
//  Created by mac on 11/4/21.
//

import UIKit

class DateSelectionTableviewController: UITableViewController {
    
    var timeSeriesMonthlyAdjusted: TimeSeriesMonthlyAdjusted?
    var monthInfos: [MonthInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMonthInfos()
    }
    
    func setupMonthInfos() {
        
        if let monthInfos = timeSeriesMonthlyAdjusted?.getMonthInfos(){
            self.monthInfos = monthInfos
        }
  
    }
       
    
}

extension DateSelectionTableviewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthInfos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DateSelectionTableViewCell
        let index = indexPath.item
        let monthInfo = monthInfos[index]
        cell.configure(with: monthInfo, index: index)
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


class DateSelectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var monthsAgoLabel: UILabel!
    
    func configure(with monthInfo: MonthInfo, index:Int) {
       // backgroundColor = .red // a way of checking that the high level function works with this
        monthLabel.text = monthInfo.date.MMYYFormat
        
        if index == 1 {
            monthsAgoLabel.text = "1 month ago"
        }
        else if index > 1 {
            monthsAgoLabel.text = "\(index) months ago"
        }
        else{
            monthsAgoLabel.text = "Just invested"
        }
    }
}
