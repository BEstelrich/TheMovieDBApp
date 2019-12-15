//
//  Movie.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-15.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import Foundation

// MARK: - JSON
struct JSON: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable {
    let id: Int
    let posterPath: String
    let title: String?
    let name: String?
    let popularity: Double

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case name
        case popularity
    }
}

//struct Movie: Codable {
//    let id: Int
//    let video: Bool?
//    let voteCount: Int
//    let voteAverage: Double
//    let title: String?
//    let name: String?
//    let releaseDate: String?
//    let originalTitle: String?
//    let genreIDS: [Int]
//    let backdropPath: String
//    let adult: Bool?
//    let overview, posterPath: String
//    let popularity: Double
//    let originCountry: [String]?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case title
//        case video
//        case voteCount = "vote_count"
//        case voteAverage = "vote_average"
//        case name
//        case releaseDate = "release_date"
//        case originalTitle = "original_title"
//        case genreIDS = "genre_ids"
//        case backdropPath = "backdrop_path"
//        case adult
//        case overview
//        case posterPath = "poster_path"
//        case popularity
//        case originCountry = "origin_country"
//    }
//}
