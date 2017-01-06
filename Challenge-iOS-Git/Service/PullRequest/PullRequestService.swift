//
//  PullRequestService.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit

class PullRequestService: NSObject {
    
    class func getPullRequests(creator: String, repository: String,
                               onSuccess: (listOfPulls: [PullRequest]?, serviceResponse: ServiceResponse ) -> Void,
                               onFailure failed: (serviceResponse: ServiceResponse) -> Void,
                                         onCompleted: () -> Void) {
        var url = URLFactory.PullRequestEndpoint.pullRequestURL()
        
        url += "\(creator)/\(repository)/pulls"
        
        Service.request(.GET, url, encoding: .JSON).serializedArray(onSuccess: { (listOfPulls: [PullRequest]?, res) in
            onSuccess(listOfPulls: listOfPulls, serviceResponse: res)
        }, onFailure: { (err) in
            failed(serviceResponse: err)
        }) { 
            onCompleted()
        }
        
    }

}
