//
//  RectTextTipButton.swift
//  Tipsy
//
//  Created by Christopher Martin on 5/9/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

import UIKit

@IBDesignable
open class RectTextTipButton: TextTipButton {
    
    override var textSize: CGFloat{
        return 20.0
    }
    
    //Initalizers
    override init(backgroundColor:UIColor, text:String?){
        super.init(frame: CGRect.zero)
        self.backgroundShape = ShapeView(shape: .roundedRect, color: UIColor.brown)
        self.shapeColor = backgroundColor
        self.backgroundShape.color = self.shapeColor
        self.label.attributedText = self.attributedText(self.text!, WithColor: UIColor.white, size: self.textSize)
        self.contentView = self.label
    }
    
    convenience init(backgroundColor:UIColor){
        self.init(backgroundColor:backgroundColor, text:nil)
        self.backgroundShape.color = backgroundColor
    }
    override public init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.backgroundShape = ShapeView(shape: .roundedRect, color: UIColor.brown)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundShape = ShapeView(shape: .roundedRect, color: UIColor.brown)
    }

}
