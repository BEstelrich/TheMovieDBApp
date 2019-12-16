//
//  TrendingMoviesViewController.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-13.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit
import Kingfisher

class TrendingMoviesViewController: UIViewController {
    
    @IBOutlet weak var trendingMoviesCollectionView: UICollectionView!
    
    var movies: [Movie] = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.trendingMoviesCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTrendingMoviesCollectionView()
        fetchData()
    }
    
    func fetchData() {
        let trendingMovies = NetworkRequest(apiData: FetchTrendingMovies())
        let url = URL(string: Constants.API.trendingMovies)

        trendingMovies.fetch(fromURL: url!) { [weak self] (JSONData) in
            
            let JSONData = JSONData as? JSON

            let JSONMovies = JSONData?.results
            
            for movie in JSONMovies! {
                print(movie)
                self?.movies.append(movie)
            }

            self?.movies.sort {
                $0.popularity > $1.popularity
            }
        }

    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.movieToMovieDetailsSegue {
            if let movieDetailsViewController = segue.destination as? MovieDetailsViewController {
                if let indexPath = trendingMoviesCollectionView.indexPathsForSelectedItems?.last {
                    movieDetailsViewController.movieID = movies[indexPath.item].id
                }
            }
        }
    }

}

extension TrendingMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupTrendingMoviesCollectionView() {
        trendingMoviesCollectionView.delegate   = self
        trendingMoviesCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = trendingMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.trendingMoviesCell, for: indexPath) as? TrendingMoviesCollectionViewCell else { return UICollectionViewCell() }
        
        let movie = movies[indexPath.row]
        cell.movieTitleLabel.text      = movie.title?.isEmpty == false ? movie.title : movie.name
        cell.moviePopularityLabel.text = "Popularity: \(String(describing: movie.popularity))"
        cell.moviePosterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"))
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row == movies!.count - 1 {
//            updateNextSet()
//        }
//    }
//    
//    func updateNextSet() {
//        fetchTrendingAPI(withURL: Constants.API.trendingMovies + "&page=" + "\(2)")
//    }

    
}
