//
//  TimeScoreboardButton.swift
//  Tipsy
//
//  Created by Christopher Martin on 6/25/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

import UIKit

class TimeScoreboardButton: RectScoreboardButton, AttributeTextable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setupService() {
        super.setupService()
        self.state = .filled
    }
    
    
}
