//
//  NetworkManager.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-16.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import Foundation

/// NetworkRequest is used from ViewControllers to fetch data from JSON.
class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    
    /// This class has a method that fetchs Trending Movies from JSON through an URLSession.
    func getTrendingMovies(for page: Int, completed: @escaping (Result<JSON, APIError>) -> Void) {
        let endPoint = "https://api.themoviedb.org/3/trending/movie/day?api_key=\(Constants.API.APIKey)&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData  = try decoder.decode(JSON.self, from: data)
                completed(.success(jsonData))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    /// This class has a method that fetchs Movie Details from JSON through an URLSession.
    func getMovieDetails(for movieID: Int, completed: @escaping (Result<MovieDetails, APIError>) -> Void) {
        let endPoint = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(Constants.API.APIKey)&language=en-US&append_to_response=videos"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData  = try decoder.decode(MovieDetails.self, from: data)
                completed(.success(jsonData))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}


