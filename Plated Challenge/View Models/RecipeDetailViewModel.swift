//
//  RecipeDetailViewModel.swift
//  Plated Challenge
//
//  Created by Victor Zhong on 6/2/18.
//  Copyright © 2018 Victor Zhong. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeDetailViewModel {
    var apiClient: APIClient!
    var menu: Menu!
    var recipe: Recipe!

    init(with apiClient: APIClient, menu: Menu, recipe: Recipe) {
        self.apiClient = apiClient
        self.menu = menu
        self.recipe = recipe
    }

    func getRecipeName() -> String {
        return recipe.name
    }

    func getDescription() -> String {
        return "\"\(recipe.description)!\""
    }

    func setRecipeImage(_ imageView: UIImageView) {
        let urlString = recipe.image
        guard let url = URL(string: urlString) else { return }

        imageView.kf.setImage(with: url) { (_, error, _, _) in
            if let _ = error {
                print(AppError.badImageURL(string: urlString))
            }
        }
    }

}
