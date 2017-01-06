//
//  URLFactory.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit

class URLFactory: NSObject {

    class SearchRepositoryEndpoint {
        class func searchRepositoryURL() -> String {
            return Environment.sharedEnvironment.baseURLForJavGitPop + "search/repositories"
        }
    }
    
    class PullRequestEndpoint {
        class func pullRequestURL() -> String {
            return Environment.sharedEnvironment.baseURLForJavGitPop + "repos/"
        }
    }
}
