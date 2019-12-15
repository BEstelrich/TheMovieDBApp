//
//  MovieDetailsViewController.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-14.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

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
    
    func fetchMovieDetailsAPI() {
        print(movieID)
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=af4529267a761468f007041392247475&language=en-US")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                if error == nil {
                    self.movieDetails = try JSONDecoder().decode(MovieDetails.self, from: data!)
                    
                    DispatchQueue.main.async {
                        self.populateMovieData()
                    }

                } else {
                    print("There is an error: \(error.debugDescription)")
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func populateMovieData() {
        movieTitleLabel.text          = movieDetails?.title
        movieTaglineLabel.text        = movieDetails?.tagline
        movieReleaseDateLabel.text    = movieDetails?.releaseDate
        movieVoteAverageLabel.text    = "\(String(describing: movieDetails?.voteAverage))"
        movieDescriptionTextView.text = movieDetails?.overview
        
        if movieDetails?.video == true {
            self.moviePlayTrailerButton.defaultLayout()
        } else {
            self.moviePlayTrailerButton.disabledLayout()
        }
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movieDetails!.posterPath)")
        moviePosterImageView.kf.setImage(with: url)
    }
    
}
