//
//  Views.swift
//  TheMovieDBApp
//
//  Created by BES on 2019-12-14.
//  Copyright © 2019 BEstelrich. All rights reserved.
//

import UIKit

@IBDesignable
extension UIView {
    
    func applyRoundedCourners(of radius: CGFloat) {
        self.layer.cornerRadius  = radius
        self.layer.masksToBounds = true
    }
    
}
