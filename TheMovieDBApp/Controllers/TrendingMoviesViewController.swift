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
        fetchTrendingAPI()
    }
    
    
    func fetchTrendingAPI() {
        let url = URL(string: Constants.API.trendingMovies)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                if error == nil {
                    let result = try JSONDecoder().decode(JSON.self, from: data!)
                    self.movies = result.results
                    
                    let sortedByPopularity = self.movies?.sorted {
                        $0.popularity > $1.popularity
                    }
                    
                    self.movies = sortedByPopularity
                    
                    DispatchQueue.main.async {
                        self.trendingMoviesCollectionView.reloadData()
                    }
                    
                    print(self.movies?.count ?? 0)
                } else {
                    print("There is an error: \(error.debugDescription)")
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
        
        let movie = movies?[indexPath.row]
        
        cell.movieTitleLabel.text = (movie?.title?.isEmpty == false ) ? movie?.title : movie?.name
        cell.moviePopularityLabel.text = "Popularity: \(String(describing: movie?.popularity ?? 0))"
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie!.posterPath)")
        cell.moviePosterImageView.kf.setImage(with: url)
        
        return cell
    }

    
}
