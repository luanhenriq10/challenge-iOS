//
//  UIViewControllerExtension.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit
import PKHUD

extension UIViewController {
    
    public func showLoading() {
        HUD.show(.Progress)
    }
    
    public func hideLoadingWith(time: NSTimeInterval) {
        HUD.hide(afterDelay: time)
    }
    
    public func hideLoading() {
        HUD.hide(animated: false)
    }
    
    func displayAlertForServiceWrap(serviceResponse: ServiceResponse, dismissBlock block: (() -> Void)?) {
        AlertUtil.displayAlertForServiceWrap(serviceResponse, dismissBlock: block, forViewController: self)
    }
    
    public func displayDualButtonAlert(title: String? = nil, message: String? = nil, rightButtonTitle: String!, rightButtonCallback: (alert: UIAlertController) -> Void, leftButtonTitle: String!, leftButtonCallback: (alert: UIAlertController) -> Void) {
        
        AlertUtil.displayDualButtonAlert(title, message: message, rightButtonTitle: rightButtonTitle, rightButtonCallback: rightButtonCallback, leftButtonTitle: leftButtonTitle, leftButtonCallback: leftButtonCallback, forViewController: self)
    }
    
    public func displaySingleButtonAlert(title: String? = nil, message: String? = nil, buttonTitle: String!, buttonCallback: (alert: UIAlertController) -> Void) {
        AlertUtil.displaySingleButtonAlert(title, message: message, buttonTitle: buttonTitle, buttonCallback: buttonCallback, forViewController: self)
    }
}

