//
//  PullRequest.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit
import ObjectMapper

struct PullRequest: Mappable {

    var title: String?
    var createdDate: String?
    var body: String?
    var owner: Owner?
    var base: PullRequestBase?
    var url: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.url            <- map["html_url"]
        self.title          <- map["title"]
        self.body           <- map["body"]
        self.owner          <- map["user"]
        self.createdDate    <- map["created_at"]
        self.base           <- map["base"]
        
        if self.createdDate != nil {
            self.createdDate  = NSDate.dateFromDate(self.createdDate!)
        }
        
        
    }
}
