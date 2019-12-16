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
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTaglineLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieVoteAverageLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var moviePosterImageView: MoviePosterView!
    @IBOutlet weak var moviePlayTrailerButton: PlayTrailerButton!
    
    var movieDetails: MovieDetails?
    var movieID: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetailsAPI()
    }
    
    @IBAction func tapToCloseView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapToPlayTrailerButton(_ sender: PlayTrailerButton) {

    }
    
    func fetchMovieDetailsAPI() {
        print(movieID)
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=af4529267a761468f007041392247475&language=en-US&append_to_response=videos")
        
        URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
            do {
                if error == nil {
                    self?.movieDetails = try JSONDecoder().decode(MovieDetails.self, from: data!)
                    
                    DispatchQueue.main.async {
                        self?.populateMovieData()
                    }

                } else {
                    print("Fetching Movie Details API error: \(error.debugDescription)")
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func populateMovieData() {
        movieTitleLabel.text          = movieDetails?.title.isEmpty == false ? movieDetails?.title : movieDetails?.originalTitle
        movieTaglineLabel.text        = movieDetails?.tagline
        movieReleaseDateLabel.text    = "RELEASED: " + (movieDetails?.releaseDate ?? "N/A")
        movieVoteAverageLabel.text    = movieDetails?.voteAverage != nil ? "★ " + "\(movieDetails!.voteAverage)" : "★ N/A"
        movieDescriptionTextView.text = movieDetails?.overview
        movieDetails?.videos.results.count != 0 ? moviePlayTrailerButton.defaultLayout() : moviePlayTrailerButton.disabledLayout()
        moviePosterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movieDetails!.posterPath)"))
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.movieDetailsToTrailerPlayerSegue {
            if let trailerPlayerViewController = segue.destination as? TrailerPlayerViewController {
                trailerPlayerViewController.videoKey = movieDetails?.videos.results.first?.key
            }
        }
    }

}
