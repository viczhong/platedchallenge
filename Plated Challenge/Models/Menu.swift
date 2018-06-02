//
//  Menu.swift
//  Plated Challenge
//
//  Created by Victor Zhong on 6/1/18.
//  Copyright © 2018 Victor Zhong. All rights reserved.
//

import Foundation

struct Menus: Codable {
    let menus: [Menu]
}

struct Menu: Codable {
    let id: Int
    let title: String
}
