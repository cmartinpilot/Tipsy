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
open class ScoreboardButton: UIView {
    
    open var shapeType:ShapeType = .circle {
        didSet{
            self.shape.shape = shapeType
        }
    }
    
    fileprivate var shapeColor:UIColor = UIColor.black{
        didSet{
            self.shape.color = shapeColor
        }
    }
    
    @IBInspectable open var defaultShapeColor:UIColor = UIColor.black{
        didSet{
            self.shapeColor = defaultShapeColor
        }
    }
   
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
                self.shapeColor = self.defaultShapeColor
                self.shape.drawWithStrokeOnly = true
                self.shape.strokeWithDottedLine = true
            case .filled:
                self.shape.drawWithStrokeOnly = false
                self.shape.strokeWithDottedLine = false
            case .multiplefilled:
                print("yay")
                //self.backgroundView.hidden = true
                //self.shape.color = UIColor.blueColor()
            case .selected:
                self.shape.drawWithStrokeOnly = false
                self.shape.strokeWithDottedLine = false
                self.delegate?.scoreboardButtonWasSelected(self)
            }
        }
    }
    
    fileprivate var shape:ShapeView = ShapeView(shape: .circle, color: UIColor.black)
    
    override public init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup(){
//        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.shape.color = self.defaultShapeColor
        self.shape.shape = self.shapeType
        self.shape.drawWithStrokeOnly = true
        self.shape.strokeWithDottedLine = true
        self.shape.drawWithStrokeAndFill = true
        
        //add gesture recognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ScoreboardButton.tapped))
        
        self.addGestureRecognizer(tapRecognizer)

    }
    
    func tapped(){
        print("Scoreboard Button tapped")
        self.state = .selected
    }
    
    override open func layoutSubviews() {
        self.addSubview(self.backgroundView)
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.shape)
        
        if self.contentView != nil{
            self.shape.addSubview(self.contentView!)
            self.contentView!.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //add Constraints
        self.shape.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.shape.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.shape.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.shape.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.backgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.backgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        if self.contentView != nil{
            self.contentView?.centerXAnchor.constraint(equalTo: self.shape.centerXAnchor).isActive = true
            self.contentView?.centerYAnchor.constraint(equalTo: self.shape.centerYAnchor).isActive = true
        }else{
            self.contentView?.centerXAnchor.constraint(equalTo: self.shape.centerXAnchor).isActive = false
            self.contentView?.centerYAnchor.constraint(equalTo: self.shape.centerYAnchor).isActive = false
        }
    }
    
    func changeStateTo(_ buttonState:ScoreboardButtonState, ofColor:UIColor?, withView view:UIView?){
        
        //If a color was passed, use it.  Otherwise, color remains same
        if let color = ofColor{
            self.shapeColor = color
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
