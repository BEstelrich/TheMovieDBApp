//
//  MovieDetails.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-15.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import Foundation

import Foundation

/// MOVIEDETAILS
/// MovieDetails and its depending structures are used to populate MovieDetailViewController including video links.
struct MovieDetails: Codable {
    
    let id: Int
    let posterPath: String
    let video: Bool
    let title: String
    let originalTitle: String
    let tagline: String
    let releaseDate: String
    let voteAverage: Double
    let overview: String
    let videos: Videos
    

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


struct Videos: Codable {
    
    let results: [Video]
    
}


struct Video: Codable {
    
    let key: String


    enum CodingKeys: String, CodingKey {
        case key
    }
    
}
