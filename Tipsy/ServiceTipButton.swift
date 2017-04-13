//
//  ServiceTipButton.swift
//  Tipsy
//
//  Created by Christopher Martin on 5/4/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

import UIKit

@IBDesignable
open class ServiceTipButton: TipButton {

    @IBInspectable open var image:UIImage?{
        didSet{
            let imageView = UIImageView(image: image)
            self.contentView = imageView
        }
    }
    
    @IBInspectable open var miniImage:UIImage?
    
    override open var buttonDescription:ButtonDescription{
        return .service
    }
    
    //Initalizers
    init(backgroundColor:UIColor, image:UIImage?){
        super.init(frame: CGRect.zero)
        self.color = backgroundColor
        let imageView = UIImageView(image: image)
        self.contentView = imageView
    }
    
    convenience init(backgroundColor:UIColor){
        self.init(backgroundColor:backgroundColor, image:nil)
        self.color = backgroundColor
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
