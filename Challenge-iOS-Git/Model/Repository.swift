//
//  JavaRepositories.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit
import ObjectMapper

struct Repository: Mappable {
    
    var name: String?
    var description: String?
    var owner: Owner?
    var starsQtd: Int?
    var forksQtd: Int?
    
    init() {
        
    }
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.name           <- map["name"]
        self.description    <- map["description"]
        self.owner          <- map["owner"]
        self.starsQtd       <- map["stargazers_count"]
        self.forksQtd       <- map["forks_count"]
    }
}
