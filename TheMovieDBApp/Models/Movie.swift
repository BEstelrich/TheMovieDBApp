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
struct Movie: Codable {
    
    let id        : Int
    let posterPath: String
    let title     : String?
    let name      : String?
    let popularity: Double
    

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case name
        case popularity
    }
    
}
