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
    
    // Through this extension rounded courners can be applied to any UIView object.
    func applyRoundedCourners(of radius: CGFloat) {
        self.layer.cornerRadius  = radius
        self.layer.masksToBounds = true
    }
    
}
