//
//  SearchRepositoryService.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit

class SearchRepositoryService: NSObject {

    class func getJavaRepository(page: Int,
                                 onSuccess: (javaRepositories: RepositoryServiceResponse?, serviceResponse: ServiceResponse) -> Void,
                                 onFailure failed: (serviceResponse: ServiceResponse) -> Void,
                                           onCompleted: ( )-> Void) {
        
        var url = URLFactory.SearchRepositoryEndpoint.searchRepositoryURL()
        
        url     += "?q=language:Java&sort=stars&page=\(page)"
        
        Service.request(.GET, url, encoding: .JSON).serializedObject(onSuccess: { (javaRepositories: RepositoryServiceResponse?, res) in
            onSuccess(javaRepositories: javaRepositories, serviceResponse: res)
            }, onFailure: { (err) in
                failed(serviceResponse: err)
            }) { 
                onCompleted()
        }
    }
}
