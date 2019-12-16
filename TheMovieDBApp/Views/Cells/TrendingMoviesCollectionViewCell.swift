//
//  TrendingMoviesCollectionViewCell.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-14.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

class TrendingMoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieTitleLabel        : UILabel!
    @IBOutlet weak var moviePopularityLabel   : UILabel!
    @IBOutlet weak var moviePosterImageView   : UIImageView!
    @IBOutlet weak var movieCellBackgroundView: MovieCellBackgroundView!
    
}
