//
//  File.swift
//  cats
//
//  Created by Sumo Akula on 3/1/22.
//

import SwiftUI

struct CatView: View {
    var cat: Cat
    
    var body: some View {
        VStack {
            if (!self.cat.breeds.isEmpty) {
                ForEach(self.cat.breeds) { breed in
                    VStack {
                        Link(breed.name, destination: URL(string: breed.wikipedia_url)!)
                    }
                }
            }
            
            AsyncImage(url: URL(string: cat.url)) { phase in
                if let image = phase.image {
                    image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                } else if let error = phase.error {
                    Text("\(Image(systemName: "exclamationmark.triangle.fill")) There was an error while loading the image")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                        .contextMenu {
                            Text("Error details: \(error.localizedDescription)")
                        }
                } else {
                    HStack(spacing: 8) {
                        ProgressView()
                        Text("Loading Image...")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}
