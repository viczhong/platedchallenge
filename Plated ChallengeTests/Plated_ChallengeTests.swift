//
//  Plated_ChallengeTests.swift
//  Plated ChallengeTests
//
//  Created by Victor Zhong on 6/1/18.
//  Copyright © 2018 Victor Zhong. All rights reserved.
//

import XCTest
@testable import Plated_Challenge

class Plated_ChallengeTests: XCTestCase {
    var urlBuilderUnderTest: UrlBuilder!

    override func setUp() {
        super.setUp()
        urlBuilderUnderTest = UrlBuilder.manager
    }
    
    override func tearDown() {
        urlBuilderUnderTest = nil
        super.tearDown()
    }
    
    func test_UrlBuilder_results() {
        XCTAssertEqual(urlBuilderUnderTest.getURLforMenu(), URL(string: "https://plated-coding-challenge.herokuapp.com/v1/menus/"), "UrlBuilder For All Menus isn't equal")
        XCTAssertEqual(urlBuilderUnderTest.getURLforMenu(at: 2), URL(string: "https://plated-coding-challenge.herokuapp.com/v1/menus/2"), "UrlBuilder For Specific Menu isn't equal")
        XCTAssertEqual(urlBuilderUnderTest.getURLforRecipe(at: 1) , URL(string: "https://plated-coding-challenge.herokuapp.com/v1/menus/1/recipes/"), "UrlBuilder For All Recipes isn't equal")
        XCTAssertEqual(urlBuilderUnderTest.getURLforRecipe(at: 1, for: 1), URL(string: "https://plated-coding-challenge.herokuapp.com/v1/menus/1/recipes/1"), "UrlBuilder For Specific Recipe isn't equal")
    }
    
}
