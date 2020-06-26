//
//  Constants.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-14.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit


/// Constants singleton is used to store static information in order to be accessed easily and avoid typos.
class Constants {
    
    /// API
    /// APIKey is saved in this class to be referenced from.
    final class API {
        static let APIKey = "YourAPIKeyGoesHere!"
    }
    
    
    /// IDENTIFIERS
    /// This class gathers cell identifiers.
    final class Identifiers {
        static let trendingMoviesCell: String = "TrendingMoviesCell"
    }

    
    /// SEGUES
    /// This class gathers segue identifiers.
    final class Segues {
        static let movieToMovieDetailsSegue: String = "MovieToMovieDetailsSegue"
        static let movieDetailsToTrailerPlayerSegue: String = "MovieDetailsToTrailerPlayerSegue"
    }
    
    
    private init() {  }
    
}
