//
//  RecipeDetailViewController.swift
//  Plated Challenge
//
//  Created by Victor Zhong on 6/2/18.
//  Copyright © 2018 Victor Zhong. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!

    var viewModel: RecipeDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.accessibilityIdentifier = "recipeDetailView"
        
        setupView()
    }

    func setupView() {
        nameLabel.text = viewModel.getRecipeName()
        descriptionLabel.text = viewModel.getDescription()
        viewModel.setRecipeImage(recipeImageView) 
    }
}
