//
//  RecipeTableViewCell.swift
//  Plated Challenge
//
//  Created by Victor Zhong on 6/3/18.
//  Copyright © 2018 Victor Zhong. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        foodImage.layer.cornerRadius = 16
        foodImage.clipsToBounds = true
    }

}
