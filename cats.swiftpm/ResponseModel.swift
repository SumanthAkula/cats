//
//  File.swift
//  cats
//
//  Created by Sumo Akula on 3/1/22.
//

import Foundation

struct Cat: Decodable, Identifiable {
    let id: String
    let url: String
    let width: Int
    let height: Int
    let breeds: [Breed]
}

struct Breed: Decodable, Identifiable {
    let id: String
    let name: String
    let temperament: String
    let life_span: String
    let wikipedia_url: String
}
