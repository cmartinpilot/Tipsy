//
//  LocationButton.swift
//  Tipsy
//
//  Created by Christopher Martin on 6/24/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

import UIKit

protocol DisplaysActivityIndicator {
    var activityIndicator:UIActivityIndicatorView {get}
    func startActivityAnimation()
    func endActivityAnimation()
}

open class LocationButton: RectTextTipButton, DisplaysActivityIndicator {

    open override var buttonDescription: ButtonDescription{
        return .location
    }
    
    open let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    func startActivityAnimation(){
       
        self.contentView = self.activityIndicator
        self.activityIndicator.startAnimating()
    }
    
    func endActivityAnimation() {
        
        if self.activityIndicator.isAnimating{self.activityIndicator.stopAnimating()}
        if let animatingIndicator = self.contentView{
            animatingIndicator.removeFromSuperview()
        }
        
    }
}
