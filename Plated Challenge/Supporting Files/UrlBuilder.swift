//
//  URLBuilder.swift
//  Plated Challenge
//
//  Created by Victor Zhong on 6/2/18.
//  Copyright © 2018 Victor Zhong. All rights reserved.
//

import Foundation

class UrlBuilder {
    private let baseURL = "https://plated-coding-challenge.herokuapp.com/v1/"
    static let manager = UrlBuilder()
    private init() {}

    func getURLforMenu(at id: Int? = nil) -> URL? {
        var urlString = baseURL + ModelType.menus.rawValue

        if let id = id {
            urlString += String(id)
        }

        guard let url = URL(string: urlString) else { return nil }

        return url
    }

    func getURLforRecipe(at menu: Int, for recipeID: Int? = nil) -> URL? {
        var urlString = baseURL + ModelType.menus.rawValue + String(menu) + ModelType.recipes.rawValue

        if let id = recipeID {
            urlString += String(id)
        }

        guard let url = URL(string: urlString) else { return nil }

        return url
    }
}
