//
//  AppError.swift
//  Plated Challenge
//
//  Created by Victor Zhong on 6/2/18.
//  Copyright © 2018 Victor Zhong. All rights reserved.
//

import Foundation

public enum AppError: Error {
    case badData
    case badImageData
    case badImageURL(string: String)
    case badStatusCode(num: Int)
    case badURL(string: String)
    case couldNotParseJSON(rawError: Error)
    case noInternet
    case other(rawError: Error)
}
