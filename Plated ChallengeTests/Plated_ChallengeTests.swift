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
    var recipesViewModelUndrerTest: RecipesViewModel?
    var apiClientUnderTest: APIClient?

    // MARK: - Test Setup

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

    func setUpMockSession(for viewModel: ViewModel) {
        let promise = expectation(description: "Status code: 200")

        let completion = {
            promise.fulfill()
        }

        if let vm = viewModel as? RecipesViewModel {
            vm.getRecipes { completion() }
        }
        else if let vm = viewModel as? MenusViewModel {
            vm.getMenus { completion() }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func getMockDataPath(for modelType: ModelType) -> String {
        let testBundle = Bundle(for: type(of: self))
        var path = String()

        switch modelType {
        case .menus:
            path = testBundle.path(forResource: "menus", ofType: "json")!
        case .recipes:
            path = testBundle.path(forResource: "recipes", ofType: "json")!
        }

        return path
    }

    func setupGivenFor(modelType: ModelType) {
        let data = try? Data(contentsOf: URL(fileURLWithPath: getMockDataPath(for: modelType)), options: .alwaysMapped)

        var url: URL

        switch modelType {
        case .menus:
            url = urlBuilderUnderTest.getURLforMenu()!
        case .recipes:
            url = urlBuilderUnderTest.getURLforRecipe(at: 1)!
        }

        configureAPIClient(url, data)

        switch modelType {
        case .menus:
            menusViewModelUnderTest = MenusViewModel(with:
                apiClientUnderTest!)
            setUpMockSession(for: menusViewModelUnderTest!)
        case .recipes:
            recipesViewModelUndrerTest = RecipesViewModel(with:
                apiClientUnderTest!, menu: Menu(id: 1, title: "Lunch"))
            setUpMockSession(for: recipesViewModelUndrerTest!)
        }
    }

    // MARK: - Tests

    func test_UrlBuilder_results() {
        XCTAssertEqual(urlBuilderUnderTest.getURLforMenu(), URL(string: "https://plated-coding-challenge.herokuapp.com/v1/menus/"), "UrlBuilder For All Menus isn't equal")
        XCTAssertEqual(urlBuilderUnderTest.getURLforMenu(at: 2), URL(string: "https://plated-coding-challenge.herokuapp.com/v1/menus/2"), "UrlBuilder For Specific Menu isn't equal")
        XCTAssertEqual(urlBuilderUnderTest.getURLforRecipe(at: 1) , URL(string: "https://plated-coding-challenge.herokuapp.com/v1/menus/1/recipes/"), "UrlBuilder For All Recipes isn't equal")
        XCTAssertEqual(urlBuilderUnderTest.getURLforRecipe(at: 1, for: 1), URL(string: "https://plated-coding-challenge.herokuapp.com/v1/menus/1/recipes/1"), "UrlBuilder For Specific Recipe isn't equal")
    }

    // MARK: MenusViewModelTests

    func test_MenusViewModel_ParsesData() {
        setupGivenFor(modelType: .menus)

        XCTAssertEqual(menusViewModelUnderTest?.menus?.count, 2, "MenusViewModel.menus should have 2 results")
    }

    func test_MenusViewModel_GetsTitles() {
        setupGivenFor(modelType: .menus)

        XCTAssertEqual(menusViewModelUnderTest?.menuTitleToDisplay(for: [0, 0]), "Lunch", "Should be Lunch")
        XCTAssertEqual(menusViewModelUnderTest?.menuTitleToDisplay(for: [0, 1]), "Dinner", "Should be Dinner")
    }

    // MARK: RecipesViewModelTests

    func test_RecipesViewModel_ParseData() {
        setupGivenFor(modelType: .recipes)

        XCTAssertEqual(recipesViewModelUndrerTest?.recipes?.count, 5, "RecipesViewModel.recipes should have 5 results")
    }

    func test_RecipesViewModel_GetsNames() {
        setupGivenFor(modelType: .recipes)

        XCTAssertEqual(recipesViewModelUndrerTest?.recipeNameToDisplay(for: [0, 0]), "Braised Pork Apricots and Currants", "Should be \"Braised Pork Apricots and Currants\"")
        XCTAssertEqual(recipesViewModelUndrerTest?.recipeNameToDisplay(for: [0, 1]), "Caprese Chicken over Warm Spinach Salad", "Should be \"Caprese Chicken over Warm Spinach Salad\"")
    }

    func test_RecipesViewModel_GetsDescriptions() {
        setupGivenFor(modelType: .recipes)

        XCTAssertEqual(recipesViewModelUndrerTest?.recipeDescriptionToDisplay(for: [0, 0]), "Salty and sweet", "Should be \"Salty and sweet\"")
        XCTAssertEqual(recipesViewModelUndrerTest?.recipeDescriptionToDisplay(for: [0, 1]), "Extra crispy", "Should be \"Extra crispy\"")
    }
}
