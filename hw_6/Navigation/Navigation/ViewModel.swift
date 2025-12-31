//
//  ViewModel.swift
//  Navigation
//
//  Created by OstapMamykin on 31.12.2025.
//

import Observation
import Foundation


@Observable
final class ViewModel {
    var movies: [Movie] = []
    
    var searchText: String = ""
    var sortOption: SortOption = .title
    
    enum SortOption {
        case title, year
    }
    
    var filteredMovies: [Movie] {
        let result = searchText.isEmpty ? movies : movies.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.genre.localizedCaseInsensitiveContains(searchText)
        }
        
        switch sortOption {
        case .title:
            return result.sorted { $0.title < $1.title }
        case .year:
            return result.sorted { $0.releaseYear > $1.releaseYear } // Newest first
        }
    }
    
    init() {
        loadMovies()
    }
    
    func addMovie(title: String, genre: String, year: String, description: String) {
        let newMovie = Movie(
            id: UUID(),
            title: title,
            genre: genre,
            description: description,
            releaseYear: year
        )
        movies.insert(newMovie, at: 0)
        saveMovies()
    }
    
    func removeMovie(at offsets: IndexSet) {
        let itemsToDelete = offsets.map { filteredMovies[$0] }
        for item in itemsToDelete {
            if let index = movies.firstIndex(where: { $0.id == item.id }) {
                movies.remove(at: index)
            }
        }
        saveMovies()
    }
    
    func saveData() {
        saveMovies()
    }
    
    private let saveKey = "saved_movies_v1"
    
    private func saveMovies() {
        if let encoded = try? JSONEncoder().encode(movies) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadMovies() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Movie].self, from: data) {
            movies = decoded
        } else {
            movies = [
                .init(id: UUID(), title: "The Shawshank Redemption", genre: "Drama", description: "Two imprisoned men bond over their shared experiences.", releaseYear: "1994"),
                .init(id: UUID(), title: "The Godfather", genre: "Crime", description: "The epic saga of the Corleone family.", releaseYear: "1972")
            ]
        }
    }
}
