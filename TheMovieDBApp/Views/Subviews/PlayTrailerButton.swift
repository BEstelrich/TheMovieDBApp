//
//  PlayTrailerButton.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-15.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit


@IBDesignable
class PlayTrailerButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultLayout()
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultLayout()
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        defaultLayout()
    }
    
    
    /// This is the button setup used to display on the button when there are links to show in the correpondent movie.
    func defaultLayout() {
        self.isEnabled        = true
        self.backgroundColor  = UIColor.systemBlue
        self.setTitle("▶︎  Trailer", for: .normal)
        self.applyRoundedCourners(of: 12)
    }
    
    
    /// This is the button setup used to display on the button when there are no links to show in the correpondent movie.
    func disabledLayout() {
        self.isEnabled        = false
        self.backgroundColor  = UIColor.systemGray
        self.setTitle("Trailer N/A", for: .normal)
        self.applyRoundedCourners(of: 12)
    }

}
