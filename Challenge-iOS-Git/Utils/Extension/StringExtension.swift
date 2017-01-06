//
//  StringExtension.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit

extension String {

    // For localize in localizableStrings
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localize(comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }

}
