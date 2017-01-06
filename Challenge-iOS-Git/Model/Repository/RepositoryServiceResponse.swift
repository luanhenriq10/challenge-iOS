//
//  SearchRepositoryResponse.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit
import ObjectMapper

struct RepositoryServiceResponse: Mappable {
    
    var totalCount: Int?
    var incompleteResult: Bool?
    var items: [Repository]?
    
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.totalCount         <- map["total_count"]
        self.incompleteResult   <- map["incomplete_results"]
        self.items              <- map["items"]
    }

}
