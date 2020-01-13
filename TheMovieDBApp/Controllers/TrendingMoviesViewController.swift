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
    
    enum Section: CaseIterable { case main }
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    var currentPageCount: Int = 1
    var pageCountLimit: Int?
    
    var movies = [Movie]()

    
    // MARK: - ViewController lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureCollectionViewDataSource()
        fetchData(fromPage: currentPageCount)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        performSearch(searchQuery: nil)
    }
    
    
    // MARK: - Local methods.
    /// The FetchData method has an instance of the NetworkRequest class to fetch the actual data coming from JSON and sort movies by popularity.
    func fetchData(fromPage page: Int) {
        let trendingMovies = NetworkRequest(apiData: FetchTrendingMovies())
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(Constants.API.APIKey)&page=\(page)")

        trendingMovies.fetch(fromURL: url!) { [weak self] (JSONData) in
            guard let self = self else { return }
            
            let JSONData = JSONData as? JSON
            let JSONMovies = JSONData?.results
            
            self.pageCountLimit = JSONData?.totalPages
            
            for movie in JSONMovies ?? [Movie]() {
                self.movies.append(movie)
            }
        }
        
        DispatchQueue.main.async { self.updateData() }
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
extension TrendingMoviesViewController: UICollectionViewDelegate {

    /// This method configures de CollectionViewData source
    func configureCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: trendingMoviesCollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, movie: Movie) -> UICollectionViewCell? in
            let cell = self.trendingMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.trendingMoviesCell, for: indexPath) as! TrendingMoviesCollectionViewCell
            cell.movieTitleLabel.text      = movie.title?.isEmpty == false ? movie.title : movie.name
            cell.moviePopularityLabel.text = "Popularity: \(String(format:"%.3f", movie.popularity))"
            cell.moviePosterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"))
            return cell
        }
    }
    
    
    /// UpdateData is the function that applies changes to the current snapshot.
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    /// That's the function that sets the movies filtering criteria.
    func performSearch(searchQuery: String?) {
        let filteredCountries: [Movie]
        
        if let searchQuery = searchQuery, !searchQuery.isEmpty {
            filteredCountries = movies.filter { $0.contains(query: searchQuery) }
        } else {
            filteredCountries = movies
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredCountries, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}


extension TrendingMoviesViewController: UISearchBarDelegate {
    
    /// This methods adds a searchController in the menubar defining a placeholder and setting the delegate to the current viewController.
    func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movies"
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    
    /// By adding this method the filtering action performs every time there is a change in the searchBar text.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performSearch(searchQuery: searchText)
    }
    
}
