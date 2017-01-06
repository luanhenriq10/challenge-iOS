//
//  OwnerRepository.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit
import ObjectMapper

struct Owner: Mappable {
    
    var avatar_url: String?
    var login: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.avatar_url <- map["avatar_url"]
        self.login      <- map["login"]
    }
}
