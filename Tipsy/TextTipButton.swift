//
//  TextTipButton.swift
//  Tipsy
//
//  Created by Christopher Martin on 5/9/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

import UIKit

@IBDesignable
open class TextTipButton: TipButton {
    
//    Properties
    @IBInspectable open var text:String?{
        didSet{
            
            if self.text != nil{
                self.label.attributedText = self.attributedText(self.text!, WithColor: UIColor.white, size: self.textSize)
                self.contentView = self.label
            }
        }
    }
    
    var textSize:CGFloat{
        return 24.0
    }
    
    internal let label:UILabel = UILabel()

    
    //Initalizers
    init(backgroundColor:UIColor, text:String?){
        super.init(frame: CGRect.zero)
        self.color = backgroundColor
        self.label.attributedText = self.attributedText(self.text!, WithColor: UIColor.white, size: self.textSize)
        self.contentView = self.label
    }
    
    convenience init(backgroundColor:UIColor){
        self.init(backgroundColor:backgroundColor, text:nil)
        self.color = backgroundColor
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    //Helper function
    
    func attributedText(_ text: String, WithColor color:UIColor, size:CGFloat) -> NSAttributedString {
        let font = UIFont(name: "Antipasto", size: size)
        let attributes = [NSFontAttributeName:font!,NSForegroundColorAttributeName:color]
        let attributedAmount = NSAttributedString(string: text, attributes: attributes)
        return attributedAmount
    }

}
