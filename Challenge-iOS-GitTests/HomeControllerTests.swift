//
//  HomeControllerTests.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 04/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import XCTest
@testable import Challenge_iOS_Git

class HomeControllerTests: XCTestCase {
    
    var homeController: HomeViewController!
    
    override func setUp() {
        super.setUp()
        
        // Testing if table view can receive nil itens
        self.homeController = HomeViewController.newInstanceFromStoryboard()
        
    }
    
    override func tearDown() {
        super.tearDown()
        self.homeController = nil
        self.repositoryItem = nil
    }
    
    
}
