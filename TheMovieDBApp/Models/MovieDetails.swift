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
//struct MovieDetails: Codable {
//    let backdropPath: String
//    let budget: Int
//    let homepage: String
//    let id: Int
//    let imdbID, originalLanguage, originalTitle, overview: String
//    let popularity: Double
//    let posterPath: String
//    let releaseDate: String
//    let revenue, runtime: Int
//    let status, tagline, title: String
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int
//
//    enum CodingKeys: String, CodingKey {
//        case backdropPath = "backdrop_path"
//        case budget
//        case homepage
//        case id
//        case imdbID = "imdb_id"
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview, popularity
//        case posterPath = "poster_path"
//        case releaseDate = "release_date"
//        case revenue, runtime
//        case status
//        case tagline
//        case title
//        case video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
//}

struct MovieDetails: Codable {
    let id         : Int
    let title      : String
    let popularity : Double
    let posterPath : String
    let releaseDate: String
    let tagline    : String
    let video      : Bool
    let voteAverage: Double
    let overview   : String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case tagline
        case video
        case voteAverage = "vote_average"
        case overview
    }
}
