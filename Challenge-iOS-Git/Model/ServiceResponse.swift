//
//  ServiceResponse.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit
import ObjectMapper

struct ServiceResponse: Mappable {
    
    var code        :String?
    var title       :String?
    var message     :String?
    var detail      :String?
    
    var response:   NSHTTPURLResponse?
    var request:    NSURLRequest?
    
    init?(_ map: Map) {
        
    }

    init() {
        
    }
    
    mutating func mapping(map: Map) {
        self.code       <- map["code"]
        self.title      <- map["title"]
        self.message    <- map["message"]
        self.detail     <- map["detail"]
    }
}
