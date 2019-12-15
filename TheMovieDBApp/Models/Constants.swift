//
//  Constants.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-14.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class Constants {
    
    final class Identifiers {
        static let trendingMoviesCell: String = "TrendingMoviesCell"
    }
    
    final class Design {
        static let roundedCornersRadius: CGFloat = 20
    }
    
    final class API {
        private let APIKey = "af4529267a761468f007041392247475"
        static let trendingMovies: String = "https://api.themoviedb.org/3/trending/movie/day?api_key=af4529267a761468f007041392247475"
    }
    
    final class Segues {
        static let movieToMovieDetailsSegue: String = "MovieToMovieDetailsSegue"
    }
    
    private init() {  }
}
