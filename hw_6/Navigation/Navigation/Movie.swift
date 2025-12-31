//
//  Movie.swift
//  Navigation
//
//  Created by OstapMamykin on 31.12.2025.
//

import Foundation


struct Movie: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var genre: String
    var description: String
    var releaseYear: String
    
    var imageSystemName: String {
        switch genre.lowercased() {
        case "action": return "flame"
        case "sci-fi": return "star.fill"
        case "drama": return "theatermasks"
        case "comedy": return "face.smiling"
        default: return "film"
        }
    }
}
