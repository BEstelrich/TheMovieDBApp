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
    
    var currentPageCount: Int = 1
    var pageCountLimit: Int?
    
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
        fetchData(fromPage: currentPageCount)
    }
    
    
    func updateNextPage() {
        currentPageCount += 1
        fetchData(fromPage: currentPageCount)
    }
    
    
    func fetchData(fromPage page: Int) {
        let trendingMovies = NetworkRequest(apiData: FetchTrendingMovies())
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(Constants.API.APIKey)&page=\(page)")

        trendingMovies.fetch(fromURL: url!) { [weak self] (JSONData) in
            let JSONData = JSONData as? JSON
            let JSONMovies = JSONData?.results
            
            self?.pageCountLimit = JSONData?.totalPages
            
            for movie in JSONMovies! {
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


// MARK: - CollectionView
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
        cell.moviePopularityLabel.text = "Popularity: \(String(format:"%.3f", movie.popularity))"
        cell.moviePosterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"))
        
        return cell
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleCells: [IndexPath] = trendingMoviesCollectionView.indexPathsForVisibleItems
        let lastIndexPath: IndexPath  = IndexPath(item: (movies.count - 1), section: 0)

        if visibleCells.contains(lastIndexPath) && currentPageCount <= pageCountLimit! {
            updateNextPage()
            
        }
    }
    
}
