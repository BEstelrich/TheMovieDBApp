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
    
    var movies: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTrendingMoviesCollectionView()
        fetchTrendingAPI(withURL: Constants.API.trendingMovies)
    }
    
    
    func fetchTrendingAPI(withURL url: String) {
        let url = URL(string: url)
        
        URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
            do {
                if error == nil {
                    let result = try JSONDecoder().decode(JSON.self, from: data!)
                    
//                    for movie in result.results {
//                        self?.movies?.append(movie)
//                    }
                    
                    self?.movies = result.results
                    
                    self?.movies?.sort {
                        $0.popularity > $1.popularity
                    }
                    
                    print(self!.movies?.count)
                    
                    DispatchQueue.main.async {
                        self?.trendingMoviesCollectionView.reloadData()
                    }
                } else {
                    print("Fetching Trending Movies API error: \(error.debugDescription)")
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.movieToMovieDetailsSegue {
            if let movieDetailsViewController = segue.destination as? MovieDetailsViewController {
                if let indexPath = trendingMoviesCollectionView.indexPathsForSelectedItems?.last {
                    movieDetailsViewController.movieID = movies?[indexPath.item].id ?? 0
                    print(movies?[indexPath.item].id ?? 0)
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
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = trendingMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.trendingMoviesCell, for: indexPath) as? TrendingMoviesCollectionViewCell else { return UICollectionViewCell() }
        
//        if isLastElementAtTheIndexPath(indexPath) {
//            fetchTrendingAPI(withURL: Constants.API.trendingMovies + "&page=" + "2")
//        }
        
        let movie = movies?[indexPath.row]
        cell.movieTitleLabel.text      = movie?.title?.isEmpty == false ? movie?.title : movie?.name
        cell.moviePopularityLabel.text = "Popularity: \(String(describing: movie?.popularity ?? 0))"
        cell.moviePosterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movie!.posterPath)"))
        
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
