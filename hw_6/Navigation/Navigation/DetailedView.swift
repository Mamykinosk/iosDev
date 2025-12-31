//
//  DetailedView.swift
//  Navigation
//
//  Created by OstapMamykin on 31.12.2025.
//

import SwiftUI


struct DetailedView: View {
    @Binding var movie: Movie
    var onSave: () -> Void
    
    var body: some View {
        Form {
            Section("Info") {
                TextField("Title", text: $movie.title)
                TextField("Genre", text: $movie.genre)
                TextField("Year", text: $movie.releaseYear)
                    .keyboardType(.numberPad)
            }
            
            Section("Description") {
                TextField("Description", text: $movie.description, axis: .vertical)
                    .lineLimit(3...6)
            }
        }
        .navigationTitle(movie.title)
        .onDisappear {
            onSave()
        }
    }
}
