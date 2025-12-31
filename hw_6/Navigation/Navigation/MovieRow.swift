//
//  MovieRow.swift
//  Navigation
//
//  Created by OstapMamykin on 31.12.2025.
//

import SwiftUI


struct MovieRow: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            Image(systemName: movie.imageSystemName)
                .font(.largeTitle)
                .frame(width: 40)
                .foregroundStyle(.blue)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.genre)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(movie.releaseYear)
                .font(.caption)
                .padding(6)
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(4)
        }
    }
}
