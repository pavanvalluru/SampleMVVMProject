//
//  UserProfileTableViewModelTests.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 05.06.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import XCTest
@testable import SampleProject

class UserProfileTableViewModelTests: XCTestCase {
    
    var profileViewModel: UserProfileTableViewModel!
    
    override func setUp() {
        super.setUp()
        
        self.profileViewModel = UserProfileTableViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        profileViewModel = nil
    }
    
    func testSectionHeadersInitialised() {
        
        XCTAssertNotNil(self.profileViewModel.section_headers, "Section headers can't be nil")
    }
    
    func testFirstSectionRowsCount() {
        
        XCTAssertEqual(self.profileViewModel.rows_in_section[0].count, 5)
    }
    
    func testFirstSecionTitle() {
        
        XCTAssertEqual(self.profileViewModel.section_headers[0], "Persönliche Daten")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
}

