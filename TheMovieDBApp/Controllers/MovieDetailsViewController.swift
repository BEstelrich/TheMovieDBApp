//
//  MovieDetailsViewController.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-14.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit
import AVKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - IBOulets and properties.
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTaglineLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieVoteAverageLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var moviePosterImageView: MoviePosterView!
    @IBOutlet weak var moviePlayTrailerButton: PlayTrailerButton!
    
    var movieDetails: MovieDetails?
    var movieID: Int = 0

    
    // MARK: - ViewController lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(from: movieID)
    }
    
    
    // MARK: - Local methods.
    /// The FetchData method has an instance of the NetworkRequest class to fetch the actual data coming from JSON to show movie details.
    func fetchData(from movieID: Int) {
        NetworkManager.shared.getMovieDetails(for: movieID) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let jsonData):
                self.movieDetails = jsonData
                self.populateMovieData()
                
            case .failure(let error):
                print(error.rawValue)
                break
            }
        }
    }
    
    
    /// This function populates Outlets with movie details.
    func populateMovieData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.movieTitleLabel.text          = self.movieDetails?.title.isEmpty == false ? self.movieDetails?.title : self.movieDetails?.originalTitle
            self.movieTaglineLabel.text        = self.movieDetails?.tagline
            self.movieReleaseDateLabel.text    = "RELEASED: " + (self.movieDetails?.releaseDate ?? "N/A")
            self.movieVoteAverageLabel.text    = self.movieDetails?.voteAverage != nil ? "★ " + "\(self.movieDetails!.voteAverage)" : "★ N/A"
            self.movieDescriptionTextView.text = self.movieDetails?.overview
            self.movieDetails?.videos.results.count != 0 ? self.moviePlayTrailerButton.defaultLayout() : self.moviePlayTrailerButton.disabledLayout()
            
            if self.movieDetails?.posterPath != nil {
                self.moviePosterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(self.movieDetails!.posterPath)"))
            }
        }
    }
    
    
    // MARK: - IBActions.
    @IBAction func tapToCloseView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Segues.
    /// On this method we're passing the YouTube video key to the TrailerPlayerViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.movieDetailsToTrailerPlayerSegue {
            if let trailerPlayerViewController = segue.destination as? TrailerPlayerViewController {
                trailerPlayerViewController.videoKey = movieDetails?.videos.results.first?.key
            }
        }
    }

}
