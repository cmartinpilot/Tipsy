//
//  RectScoreboardButton.swift
//  Tipsy
//
//  Created by Christopher Martin on 6/21/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

import UIKit

open class RectScoreboardButton: ScoreboardButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupService()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupService()
    }
    
    func setupService(){
        self.shapeType = .roundedRect
    }
    
}
