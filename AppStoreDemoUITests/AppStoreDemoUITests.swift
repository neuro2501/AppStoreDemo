//
//  AppStoreDemoUITests.swift
//  AppStoreDemoUITests
//
//  Created by NEURO on 2017. 10. 9..
//  Copyright © 2017년 develobe. All rights reserved.
//

import XCTest

class AppStoreDemoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testExample() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["뱅크샐러드 - Rainist, co.ltd"]/*[[".cells.staticTexts[\"뱅크샐러드 - Rainist, co.ltd\"]",".staticTexts[\"뱅크샐러드 - Rainist, co.ltd\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.staticTexts["뱅크샐러드 - Rainist, co.ltd"].tap()
    }
    
}
