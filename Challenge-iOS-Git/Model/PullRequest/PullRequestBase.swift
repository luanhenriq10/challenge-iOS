//
//  PullRequestHead.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 04/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit
import ObjectMapper

struct PullRequestBase: Mappable {
    
    var repo: PullRequestRepo?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.repo    <- map["repo"]
    }
}
