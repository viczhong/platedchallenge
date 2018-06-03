//
//  Plated_ChallengeUITests.swift
//  Plated ChallengeUITests
//
//  Created by Victor Zhong on 6/1/18.
//  Copyright © 2018 Victor Zhong. All rights reserved.
//

import XCTest
@testable import Plated_Challenge

class Plated_ChallengeUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func test_Segues() {
        XCTAssertTrue(app.tables["menusTableView"].exists)

        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["Lunch"]/*[[".cells.staticTexts[\"Lunch\"]",".staticTexts[\"Lunch\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()

        XCTAssertTrue(app.tables["recipesTableView"].exists)

        tablesQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["Braised Pork Apricots and Currants"]/*[[".cells.staticTexts[\"Braised Pork Apricots and Currants\"]",".staticTexts[\"Braised Pork Apricots and Currants\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()

        XCTAssertTrue(app.otherElements["recipeDetailView"].exists)
    }
}

