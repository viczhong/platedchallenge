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
    var menusViewModelUnderTest: MenusViewModel?
    var apiClientUnderTest: APIClient?

    override func setUp() {
        super.setUp()
        urlBuilderUnderTest = UrlBuilder.manager
    }
    
    override func tearDown() {
        urlBuilderUnderTest = nil
        menusViewModelUnderTest = nil
        apiClientUnderTest = nil

        super.tearDown()
    }

    func configureAPIClient(_ url: URL, _ data: Data?) {
      let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        apiClientUnderTest = APIClient()
        apiClientUnderTest?.defaultSession = URLSessionMock(data: data, response: urlResponse, error: nil)
    }

    func setUpMockSessionForMenusViewModel(_ testingVM: MenusViewModel) {
        let promise = expectation(description: "Status code: 200")

        testingVM.getMenus {
            promise.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_UrlBuilder_results() {
        XCTAssertEqual(urlBuilderUnderTest.getURLforMenu(), URL(string: "https://plated-coding-challenge.herokuapp.com/v1/menus/"), "UrlBuilder For All Menus isn't equal")
        XCTAssertEqual(urlBuilderUnderTest.getURLforMenu(at: 2), URL(string: "https://plated-coding-challenge.herokuapp.com/v1/menus/2"), "UrlBuilder For Specific Menu isn't equal")
        XCTAssertEqual(urlBuilderUnderTest.getURLforRecipe(at: 1) , URL(string: "https://plated-coding-challenge.herokuapp.com/v1/menus/1/recipes/"), "UrlBuilder For All Recipes isn't equal")
        XCTAssertEqual(urlBuilderUnderTest.getURLforRecipe(at: 1, for: 1), URL(string: "https://plated-coding-challenge.herokuapp.com/v1/menus/1/recipes/1"), "UrlBuilder For Specific Recipe isn't equal")
    }

    func test_MenusViewModel_ParsesData() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "menus", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)

        guard let url = urlBuilderUnderTest.getURLforMenu() else { return }

        configureAPIClient(url, data)

        menusViewModelUnderTest = MenusViewModel(with:
            apiClientUnderTest!)
        setUpMockSessionForMenusViewModel(menusViewModelUnderTest!)
        XCTAssertEqual(menusViewModelUnderTest?.menus?.count, 2, "MenusViewModel.menus should have 2 results")
    }

}
