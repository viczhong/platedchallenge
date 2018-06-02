//
//  Recipe.swift
//  Plated Challenge
//
//  Created by Victor Zhong on 6/1/18.
//  Copyright © 2018 Victor Zhong. All rights reserved.
//

import Foundation

struct Recipe: Codable {
    let id: Int
    let name: String
    let description: String
    let image: String
}
