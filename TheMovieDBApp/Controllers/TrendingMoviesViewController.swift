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
    
    // MARK: - IBOulets and properties.
    @IBOutlet weak var trendingMoviesCollectionView: UICollectionView!
    
    var currentPageCount: Int = 1
    var pageCountLimit: Int?
    
    var movies: [Movie] = [Movie]() {
        didSet {
            /// CollectionView is reloaded every time the movies array is set.
            DispatchQueue.main.async {
                self.trendingMoviesCollectionView.reloadData()
            }
        }
    }
    
    
    // MARK: - ViewController lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTrendingMoviesCollectionView()
        fetchData(fromPage: currentPageCount)
    }
    
    
    // MARK: - Local methods.
    /// The FetchData method has an instance of the NetworkRequest class to fetch the actual data coming from JSON and sort movies by popularity.
    func fetchData(fromPage page: Int) {
        let trendingMovies = NetworkRequest(apiData: FetchTrendingMovies())
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(Constants.API.APIKey)&page=\(page)")

        trendingMovies.fetch(fromURL: url!) { [weak self] (JSONData) in
            let JSONData = JSONData as? JSON
            let JSONMovies = JSONData?.results
            
            self?.pageCountLimit = JSONData?.totalPages
            
            for movie in JSONMovies ?? [Movie]() {
                self?.movies.append(movie)
            }
        }
    }

    
    // MARK: - Segues.
    /// On this method we're passing the movieID to the MovieDetailsViewController to be able to fetch for details in there.
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


// MARK: - Extensions
/// CollectionView Extension.
extension TrendingMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// This function assigns CollectionView delegate and dataSource to itself.
    func setupTrendingMoviesCollectionView() {
        trendingMoviesCollectionView.delegate   = self
        trendingMoviesCollectionView.dataSource = self
    }
    
    
    /// The number of items is gathered from the movies model array.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    // Populating the CollectionView cell outlets with the movies array data.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = trendingMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.trendingMoviesCell, for: indexPath) as? TrendingMoviesCollectionViewCell else { return UICollectionViewCell() }
        
        let movie = movies[indexPath.row]
        cell.movieTitleLabel.text      = movie.title?.isEmpty == false ? movie.title : movie.name
        cell.moviePopularityLabel.text = "Popularity: \(String(format:"%.3f", movie.popularity))"
        cell.moviePosterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"))
        
        return cell
    }
    
    
    /// Using this method to automatically start a new next JSON page Trending movies fetch when the last cell is shown on the screen.
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY       = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height        = scrollView.frame.size.height
        
        if offsetY > contentHeight - height, currentPageCount <= pageCountLimit! {
            currentPageCount += 1
            fetchData(fromPage: currentPageCount)
        }
    }
    
}
