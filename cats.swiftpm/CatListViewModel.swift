//
//  File.swift
//  cats
//
//  Created by Sumo Akula on 3/1/22.
//

import Foundation

class CatListViewModel: ObservableObject {
    @Published var cats: [Cat]? = nil
    @Published var averageLoadTime: Double = -1
    private var loadedAtLeastOnce: Bool = false
    
    func getData() {
        let startTime = DispatchTime.now()
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
                self.calculateTimeDifference(startTime: startTime)
                break
            }
        }
    }
    
    private func calculateTimeDifference(startTime: DispatchTime) {
        let time = Double(DispatchTime.now().uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000_000
        if !self.loadedAtLeastOnce {
            DispatchQueue.main.async {
                self.averageLoadTime = time
            }
            self.loadedAtLeastOnce.toggle()
        } else {
            DispatchQueue.main.async {
                self.averageLoadTime = (self.averageLoadTime + time) / 2
            }
        }
    }
}
