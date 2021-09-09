//
//  UIAnimatable.swift
//  DCA Financial Stock App
//
//  Created by mac on 9/10/21.
//

import Foundation
import MBProgressHUD
                    //The "where" keyword ensure that this protocol is only implementable to a UIViewController
protocol UIAnimatable where Self : UIViewController {
    
    func showLoadingAnimation()
    func hideLoadingAnimation()
}


extension UIAnimatable {
    
    func showLoadingAnimation(){
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)// set animation to the present view
        }
        
      
    }
    func hideLoadingAnimation(){
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
      
    }
}
