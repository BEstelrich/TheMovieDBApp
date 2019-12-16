//
//  Network.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-16.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import Foundation


/// API protocol adds the level of abstraction needed to be called from all ViewControllers that have to fetch for JSON data.
protocol APIData {
    
    func getData(fromURL url: URL, completion: @escaping (Codable?)->())
    
}


/// NetworkRequest is used from ViewControllers to fetch data from JSON.
class NetworkRequest {
    
    private let apiData: APIData
    
    init(apiData: APIData) {
        self.apiData = apiData
    }
    
    /// Handles API requests.
    func fetch(fromURL url: URL, completion: @escaping (Codable?) -> ()) {
        apiData.getData(fromURL: url, completion: completion)
    }
    
}


/// This class has a method that fetchs Trending Movies from JSON through an URLSession.
class FetchTrendingMovies: APIData {

    func getData(fromURL url: URL, completion: @escaping (Codable?)->()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if error == nil {
                    let JSONData = try JSONDecoder().decode(JSON.self, from: data!)
                    completion(JSONData)
                } else {
                    print("Fetching Trending Movies API error: \(error.debugDescription)")
                    completion(nil)
                }

            } catch let error {
                print("Fetching Trending Movies API error: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
}


/// This class has a method that fetchs Movie Details from JSON through an URLSession.
class FetchMovieDetails: APIData {

    func getData(fromURL url: URL, completion: @escaping (Codable?)->()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if error == nil {
                    let fetchedMovieDetails = try JSONDecoder().decode(MovieDetails.self, from: data!)
                    completion(fetchedMovieDetails)
                } else {
                    print("Fetching Movie Details API error: \(error.debugDescription)")
                    completion(nil)
                }

            } catch let error {
                print("Fetching Movie Details API error: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }

}
