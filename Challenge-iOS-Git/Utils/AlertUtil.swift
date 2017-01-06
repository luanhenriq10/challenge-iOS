//
//  AlertUtil.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit

class AlertUtil: NSObject {
    
    class func displayAlertForServiceWrap(serviceResponse: ServiceResponse, dismissBlock block: (() -> Void)?, forViewController vc: UIViewController!) {
        
        AlertUtil.displaySingleButtonAlert(serviceResponse.title, message: serviceResponse.message, buttonTitle: "Ok", buttonCallback: { (alert) in
            alert.dismissViewControllerAnimated(true, completion: block)
            }, forViewController: vc)
        
    }
    
    class func displayDualButtonAlert(title: String? = nil, message: String? = nil, rightButtonTitle: String!, rightButtonCallback: (alert: UIAlertController) -> Void, leftButtonTitle: String!, leftButtonCallback: (alert: UIAlertController) -> Void, forViewController vc: UIViewController!) {
        
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: rightButtonTitle, style: .Default, handler: { (action) in
            rightButtonCallback(alert: alert)
        }))
        
        alert.addAction(UIAlertAction(title: leftButtonTitle, style: .Default, handler: { (action) in
            leftButtonCallback(alert: alert)
        }))
        
        self.displayAlert(alert, forViewController: vc)
    }
    
    class func displaySingleButtonAlert(title: String? = nil, message: String? = nil, buttonTitle: String!, buttonCallback: (alert: UIAlertController) -> Void, forViewController vc: UIViewController!) {
        
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: .Default, handler: { (action) in
            buttonCallback(alert: alert)
        }))
        
        self.displayAlert(alert, forViewController: vc)
    }
    
    private class func displayAlert(alert: UIAlertController, forViewController vc: UIViewController) {
        vc.presentViewController(alert, animated: true, completion: nil)
    }
}
