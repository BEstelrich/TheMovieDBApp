//
//  APIError.swift
//  TheMovieDBApp
//
//  Created by BES on 2020-01-13.
//  Copyright © 2020 BEstelrich. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    
    case invalidURL       = "The URL is invalid."
    case unableToComplete = "Unable to complete the request."
    case invalidResponse  = "Invalid response from the server."
    case invalidData      = "The data received from the server was invalid."
    
}
