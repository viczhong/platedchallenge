//
//  RecipesViewModel.swift
//  Plated Challenge
//
//  Created by Victor Zhong on 6/2/18.
//  Copyright © 2018 Victor Zhong. All rights reserved.
//

import Foundation

class RecipesViewModel {
    var apiClient: APIClient!
    var menu: Menu!
    var recipes: [Recipe]?

    init(with apiClient: APIClient, menu: Menu) {
        self.apiClient = apiClient
        self.menu = menu
    }

    func title() -> String {
        return menu.title
    }

    func getRecipes(_ completionHandler: @escaping () -> Void) {
        guard let recipesURL = UrlBuilder.manager.getURLforRecipe(at: menu.id) else { return }

        let completionHandler = { [weak self] (data: Data) in
            DispatchQueue.main.async {
                do {
                    let recipes = try JSONDecoder().decode([Recipe].self, from: data)

                    self?.recipes = recipes
                    completionHandler()
                }
                catch {
                    print(AppError.couldNotParseJSON(rawError: error))
                }
            }
        }

        let errorHandler = { (error: Error) in
            print(AppError.couldNotParseJSON(rawError: error))
        }

        apiClient.performDataTask(with: recipesURL, completionHandler: completionHandler, errorHandler: errorHandler)
    }

    func numberOfItemsToDisplay(in section: Int) -> Int {
        return recipes?.count ?? 0
    }

    func recipeNameToDisplay(for indexPath: IndexPath) -> String {
        return recipes?[indexPath.row].name ?? ""
    }

    func recipeDescriptionToDisplay(for indexPath: IndexPath) -> String {
        return recipes?[indexPath.row].description ?? ""
    }
}
