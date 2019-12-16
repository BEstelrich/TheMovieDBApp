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

    
    final class API {
        static let APIKey = "af4529267a761468f007041392247475"
    }
    
    
    final class Segues {
        static let movieToMovieDetailsSegue        : String = "MovieToMovieDetailsSegue"
        static let movieDetailsToTrailerPlayerSegue: String = "MovieDetailsToTrailerPlayerSegue"
    }
    
    
    private init() {  }
    
}
