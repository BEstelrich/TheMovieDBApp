//
//  Movie.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-15.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import Foundation

/// JSON
/// This is the base struct where the model is built.
struct JSON: Codable {
    
    let page        : Int
    let results     : [Movie]
    let totalPages  : Int
    let totalResults: Int
    

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages   = "total_pages"
        case totalResults = "total_results"
    }
    
}


/// Movie
/// Movie struct is used to populate the TrendingMoviesViewController.
struct Movie: Codable, Hashable {
    
    let id: Int
    let posterPath: String
    let title: String?
    let name: String?
    let popularity: Double
    let identifier = UUID()
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    func contains(query: String?) -> Bool {
        guard let query = query else { return false }
        guard !query.isEmpty else { return false }
        
        let lowerCasedQuery = query.lowercased()
        return title!.lowercased().contains(lowerCasedQuery)
    }
    

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case name
        case popularity
    }
    
}
