//
//  TrendingMoviesCollectionViewCell.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-14.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit
import Kingfisher

class TrendingMoviesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePopularityLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieCellBackgroundView: MovieCellBackgroundView!
    
    
    func populateCell(for movie: Movie) {
        movieTitleLabel.text      = movie.title?.isEmpty == false ? movie.title : movie.name
        moviePopularityLabel.text = "Popularity: \(String(format:"%.3f", movie.popularity))"
        moviePosterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"))
    }
    
}
