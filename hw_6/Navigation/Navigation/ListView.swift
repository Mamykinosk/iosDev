//
//  ListView.swift
//  Navigation
//
//  Created by OstapMamykin on 31.12.2025.
//

import SwiftUI


struct ListView: View {
    @Bindable var viewModel: ViewModel
    @State private var path = NavigationPath()
    
    @State private var showAddSheet = false
    @State private var newTitle = ""
    @State private var newGenre = ""
    @State private var newYear = ""
    @State private var newDesc = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(viewModel.filteredMovies) { movie in
                    NavigationLink(value: movie) {
                        MovieRow(movie: movie)
                    }
                }
                .onDelete(perform: viewModel.removeMovie)
            }
            .animation(.default, value: viewModel.filteredMovies)
            .navigationTitle("All movies")
            .searchable(text: $viewModel.searchText, prompt: "Search movies...")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $viewModel.sortOption) {
                            Text("Title").tag(ViewModel.SortOption.title)
                            Text("Year").tag(ViewModel.SortOption.year)
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: Movie.self) { movie in
                DetailedView(movie: bindingMovie(movie: movie), onSave: viewModel.saveData)
            }
            .sheet(isPresented: $showAddSheet) {
                NavigationStack {
                    Form {
                        TextField("Title", text: $newTitle)
                        TextField("Genre", text: $newGenre)
                        TextField("Year", text: $newYear).keyboardType(.numberPad)
                        TextField("Description", text: $newDesc)
                    }
                    .navigationTitle("Add Movie")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { showAddSheet = false }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                viewModel.addMovie(title: newTitle, genre: newGenre, year: newYear, description: newDesc)
                                newTitle = ""; newGenre = ""; newYear = ""; newDesc = ""
                                showAddSheet = false
                            }
                            .disabled(newTitle.isEmpty)
                        }
                    }
                }
            }
        }
    }
    
    private func bindingMovie(movie: Movie) -> Binding<Movie> {
        Binding {
            viewModel.movies.first(where: { $0.id == movie.id }) ?? movie
        } set: { newValue in
            if let idx = viewModel.movies.firstIndex(where: { $0.id == movie.id }) {
                viewModel.movies[idx] = newValue
            }
        }
    }
}
