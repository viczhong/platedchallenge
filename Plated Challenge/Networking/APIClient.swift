//
//  APIClient.swift
//  Plated Challenge
//
//  Created by Victor Zhong on 6/1/18.
//  Copyright © 2018 Victor Zhong. All rights reserved.
//

import UIKit

class APIClient {

    var defaultSession: MockableURLSession = URLSession(configuration: .default)

    func performDataTask(with url: URL, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (AppError) -> Void) {
        var request = URLRequest(url: url)

        request.addValue("Token token=uDTZnGR4tFGLo1Pmizvi4Att", forHTTPHeaderField: "Authorization")

        let dataTask = defaultSession.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                if let error = error {
                    errorHandler(AppError.other(rawError: error))
                    return
                }

                if let response = response as? HTTPURLResponse, response.statusCode < 200, response.statusCode > 300 {
                    errorHandler(AppError.badStatusCode(num: response.statusCode))
                    return
                }

                if let data = data {
                    completionHandler(data)
                }
            }
        }

        dataTask.resume()
    }

}
