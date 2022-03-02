//
//  File.swift
//  cats
//
//  Created by Sumo Akula on 3/1/22.
//

import Foundation

class CatListViewModel: ObservableObject {
    @Published var cats: [Cat]? = nil
    
    func getData() {
        let manager = APIManager()
        manager.makeRequest(url: URL(string: "https://api.thecatapi.com/v1/images/search?limit=3")!) {
            (response: Result<[Cat], Error>) in
            
            switch response {
            case .failure(let error):
                print("Error getting data: \(error)")
                break
            case .success(var data):
                DispatchQueue.main.async {
                    if let cats = self.cats {
                        data.append(contentsOf: cats)
                    }
                    self.cats = Array(Set(data))
                }
                break
            }
        }
    }
}
