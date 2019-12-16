//
//  TrailerPlayerViewController.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-16.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit
import WebKit


class TrailerPlayerViewController: UIViewController {
    
    // MARK: - IBOulets and properties.
    @IBOutlet weak var videoPlayer: WKWebView!
    
    var videoKey: String?
    
    
    // MARK: - ViewController lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo(fromVideoKey: videoKey!)
    }
    
    
    // MARK: - Local methods.
    func playVideo(fromVideoKey videoKey: String) {
        guard let videoURL = URL(string: "https://www.youtube.com/embed/\(videoKey)") else { return }
        
        let videoRequest: URLRequest = URLRequest(url: videoURL)
        videoPlayer.load(videoRequest)
    }
    

    // MARK: - IBActions.
    @IBAction func tapToCloseView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

