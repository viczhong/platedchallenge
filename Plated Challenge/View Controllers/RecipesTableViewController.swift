//
//  RecipesTableViewController.swift
//  Plated Challenge
//
//  Created by Victor Zhong on 6/2/18.
//  Copyright © 2018 Victor Zhong. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    var viewModel: RecipesViewModel!
    let segueName = "detailSegue"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.accessibilityIdentifier = "recipesTableView"

        tableView.estimatedRowHeight = 115
        tableView.rowHeight = UITableViewAutomaticDimension

        title = viewModel.getMenuTitle()

        viewModel.getRecipes { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsToDisplay(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell

        cell.foodImage.image = nil
        cell.nameLabel.text = viewModel.recipeNameToDisplay(for: indexPath)
        cell.descriptionLabel?.text = viewModel.recipeDescriptionToDisplay(for: indexPath)
        
        viewModel.recipeImageToDisplay(for: indexPath, cell.foodImage!) {
            cell.setNeedsLayout()
        }

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            segue.identifier == segueName,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell),
            let recipeDetailViewController = segue.destination as? RecipeDetailViewController,
            let recipeAtRow = viewModel.recipes?[indexPath.row] {
            let recipeDetailViewModel = RecipeDetailViewModel(with:  viewModel.menu, recipe: recipeAtRow)

            recipeDetailViewController.viewModel = recipeDetailViewModel
        }
    }

}
