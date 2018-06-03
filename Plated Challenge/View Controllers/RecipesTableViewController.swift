//
//  RecipesTableViewController.swift
//  Plated Challenge
//
//  Created by Victor Zhong on 6/2/18.
//  Copyright © 2018 Victor Zhong. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    var menu: Menu!
    var apiClient: APIClient!
    var viewModel: RecipesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = RecipesViewModel(with: apiClient, menu: menu)
        title = viewModel.title()

        viewModel.getRecipes { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsToDisplay(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)

        cell.textLabel?.text = viewModel.recipeNameToDisplay(for: indexPath)
        cell.detailTextLabel?.text = viewModel.recipeDescriptionToDisplay(for: indexPath)

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
