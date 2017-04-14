//
//  ScoreboardButton.swift
//  Tipsy
//
//  Created by Christopher Martin on 5/15/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

import UIKit

public protocol ScoreboardButtonDelegate {
    func scoreboardButtonWasSelected(_ button:ScoreboardButton)
}

enum ScoreboardButtonState{
    case filled
    case multiplefilled
    case unfilled
    case selected
}

@IBDesignable
open class ScoreboardButton: ShapeView {
    
   
    @IBInspectable open var backgroundViewImage:UIImage? = nil{
        didSet{
            self.backgroundView.image = self.backgroundViewImage
        }
    }
    
    open var delegate:ScoreboardButtonDelegate?
    
    fileprivate var backgroundView:UIImageView = UIImageView()
    
    fileprivate var contentView:UIView?{
        didSet{self.setNeedsLayout()}
    }
    

    
    fileprivate var state:ScoreboardButtonState = .unfilled{
        didSet{
            switch state {
            case .unfilled:
                //self.color = self.defaultShapeColor
                self.drawWithStrokeOnly = true
                self.strokeWithDottedLine = true
            case .filled:
                self.drawWithStrokeOnly = false
                self.strokeWithDottedLine = false
            case .multiplefilled:
                print("yay")
                //self.backgroundView.hidden = true
                //self.shape.color = UIColor.blueColor()
            case .selected:
                self.drawWithStrokeOnly = false
                self.strokeWithDottedLine = false
                self.delegate?.scoreboardButtonWasSelected(self)
            }
        }
    }
    
    
    override public init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup(){
        //self.color = self.defaultShapeColor
        self.shape = .circle
        self.drawWithStrokeOnly = true
        self.strokeWithDottedLine = true
        self.drawWithStrokeAndFill = true
        
        //add gesture recognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ScoreboardButton.tapped))
        
        self.addGestureRecognizer(tapRecognizer)

    }
    
    func tapped(){
        print("Scoreboard Button tapped")
        self.state = .selected
    }
    
    override open func layoutSubviews() {
        if self.contentView == nil{
            self.contentView = self.backgroundView
        }
        
        if self.contentView != nil{
            self.addSubview(self.contentView!)
            self.contentView!.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //add Constraints
        
        
        if self.contentView != nil{
            self.contentView?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.contentView?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }else{
            self.contentView?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = false
            self.contentView?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = false
        }
    }
    
    func changeStateTo(_ buttonState:ScoreboardButtonState, ofColor:UIColor?, withView view:UIView?){
        
        //If a color was passed, use it.  Otherwise, color remains same
        if let color = ofColor{
            self.color = color
        }
        
        self.state = buttonState
        if (self.state == .multiplefilled){
            self.contentView!.removeFromSuperview()
        }
        if (self.contentView != nil){
            self.contentView!.removeFromSuperview()
        }
        self.contentView = view
        
    }
}
