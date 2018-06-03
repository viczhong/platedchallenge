//
//  MenusTableViewController.swift
//  Plated Challenge
//
//  Created by Victor Zhong on 6/2/18.
//  Copyright © 2018 Victor Zhong. All rights reserved.
//

import UIKit

class MenusTableViewController: UITableViewController {

    var viewModel: MenusViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MenusViewModel(with: APIClient())
        viewModel.getMenus { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsToDisplay(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)

        cell.textLabel?.text = viewModel.menuTitleToDisplay(for: indexPath)

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            segue.identifier == "recipesSegue",
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell),
            let recipesTableViewController = segue.destination as? RecipesTableViewController {
            recipesTableViewController.apiClient = viewModel.apiClient
            recipesTableViewController.menu = viewModel.menus?[indexPath.row]
        }
    }
}
