//
//  MovieCell.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-14.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

@IBDesignable
class MovieCellBackgroundView: UIView {
    
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
    
    
    func defaultLayout() {
        self.applyRoundedCourners(of: Constants.Design.roundedCornersRadius)
    }

    
}


@IBDesignable
class MoviePosterView: UIImageView {
    
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
    
    
    func defaultLayout() {
        self.applyRoundedCourners(of: Constants.Design.roundedCornersRadius)
    }

    
}


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
    
    
    func defaultLayout() {
        self.applyRoundedCourners(of: 12)
    }

    
}


