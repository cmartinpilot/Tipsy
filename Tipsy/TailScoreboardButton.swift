//
//  TailScoreboardButton.swift
//  Tipsy
//
//  Created by Christopher Martin on 6/10/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

import UIKit

open class TailScoreboardButton: ScoreboardButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupService()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupService()
    }
    
    func setupService(){
        self.shape = .roundedRect
        self.backgroundViewImage = UIImage(named: "FakeTailNumber")
    }
}
