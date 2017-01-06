//
//  Environment.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit

class Environment: NSObject {

    // MARK: - Properties
    static let sharedEnvironment: Environment = Environment()
    
    var baseURLForJavGitPop = "https://api.github.com/"
    
}
