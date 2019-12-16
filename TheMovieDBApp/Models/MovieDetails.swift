//
//  MovieDetails.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-15.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import Foundation

import Foundation

// MARK: - MovieDetails
struct MovieDetails: Codable {
    
    let id           : Int
    let posterPath   : String
    let video        : Bool
    let title        : String
    let originalTitle: String
    let tagline      : String
    let releaseDate  : String
    let voteAverage  : Double
    let overview     : String
    let videos       : Videos
    

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath    = "poster_path"
        case video
        case title
        case originalTitle = "original_title"
        case tagline
        case releaseDate   = "release_date"
        case voteAverage   = "vote_average"
        case overview
        case videos
    }
    
}


// MARK: - Videos
struct Videos: Codable {
    
    let results: [Video]
    
}


// MARK: - Video
struct Video: Codable {
    
    let id       : String
    let iso639_1 : String
    let iso3166_1: String
    let key      : String
    let name     : String
    let site     : String
    let size     : Int
    let type     : String

    
    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key
        case name
        case site
        case size
        case type
    }
    
}
