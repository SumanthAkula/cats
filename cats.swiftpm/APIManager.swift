//
//  File.swift
//  cats
//
//  Created by Sumo Akula on 3/1/22.
//

import SwiftUI

class APIManager {
    func makeRequest<T: Decodable>(url: URL, handler: @escaping (Result<T, Error>) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if (error != nil || data == nil) {
                handler(.failure(error!))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(T.self, from: data!)
                handler(.success(result))
            } catch let error {
                handler(.failure(error))
            }
        }
        task.resume()
    }
}
