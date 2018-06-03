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
    let segueName = "recipesSegue"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.accessibilityIdentifier = "menusTableView"

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
            segue.identifier == segueName,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell),
            let recipesTableViewController = segue.destination as? RecipesTableViewController,
            let menuAtRow = viewModel.menus?[indexPath.row] {
            let recipesViewModel = RecipesViewModel(with: viewModel.apiClient, menu: menuAtRow)

            recipesTableViewController.viewModel = recipesViewModel
        }
    }
}
