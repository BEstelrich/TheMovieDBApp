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
    
    var jsonPageCount: Int  = 1
    var jsonPageLimit: Int?
    var isSearching         = false
    
    var movies              = [Movie]()
    var filteredMovies      = [Movie]()

    
    // MARK: - ViewController lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureCollectionViewDataSource()
        fetchData(from: jsonPageCount)
    }
    
    
    // MARK: - Local methods.
    /// The FetchData method has an instance of the NetworkRequest class to fetch the actual data coming from JSON and sort movies by popularity.
    func fetchData(from page: Int) {
        NetworkManager.shared.getTrendingMovies(for: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let jsonData):
                let movies         = jsonData.results
                self.jsonPageLimit = jsonData.totalPages
                
                movies.forEach { self.movies.append($0) }
                self.updateData(on: self.movies)
                
            case .failure(let error):
                print(error.rawValue)
                break
            }
        }
    }
    
    
    /// This methods adds a searchController in the menubar defining a placeholder and setting the delegate to the current viewController.
    func configureSearchController() {
        let searchController                                  = UISearchController()
        searchController.searchResultsUpdater                 = self
        searchController.searchBar.delegate                   = self
        searchController.searchBar.placeholder                = "Search movies"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController                       = searchController
    }

    
    /// This method configures de CollectionViewData source
    func configureCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: trendingMoviesCollectionView) { (collectionView: UICollectionView, indexPath: IndexPath, movie: Movie) -> UICollectionViewCell? in
            let cell = self.trendingMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.trendingMoviesCell, for: indexPath) as! TrendingMoviesCollectionViewCell
            cell.populateCell(for: movie)
            return cell
        }
    }
    
    
    /// UpdateData is the function that applies changes to the current snapshot.
    func updateData(on movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    

    // MARK: - Segues.
    /// On this method we're passing the movieID to the MovieDetailsViewController to be able to fetch for details in there.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.movieToMovieDetailsSegue {
            if let movieDetailsViewController = segue.destination as? MovieDetailsViewController {
                if let indexPath = trendingMoviesCollectionView.indexPathsForSelectedItems?.last {
                    let activeArray                    = isSearching ? filteredMovies : movies
                    movieDetailsViewController.movieID = activeArray[indexPath.item].id
                }
            }
        }
    }

}


// MARK: - Extensions
/// CollectionView Extension.
extension TrendingMoviesViewController: UICollectionViewDelegate {
    
    /// Using this method to automatically start a new next JSON page Trending movies fetch when the last cell is shown on the screen.
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY       = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height        = scrollView.frame.size.height
        
        if offsetY > contentHeight - height, jsonPageCount <= jsonPageLimit! {
            jsonPageCount += 1
            fetchData(from: jsonPageCount)
        }
    }

}


extension TrendingMoviesViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        updateData(on: filteredMovies)
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isSearching = false
            updateData(on: movies)
            return
        }
        
        isSearching    = true
        filteredMovies = movies.filter({ $0.title!.lowercased().contains(filter.lowercased()) })
        updateData(on: filteredMovies)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: movies)
    }

}
