//
//  TipButton.swift
//  Tipsy
//
//  Created by Christopher Martin on 4/4/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

import UIKit


public enum State {
    case selected
    case deselected
}

public protocol TipButtonDelegate: class {
    func button(_ button:TipButton, willChangeState oldState:State)
    func button(_ button:TipButton, didChangeState newState:State)
}

//Enum
public enum ButtonDescription {
    case service
    case amount
    case tail
    case location
    case leg
    case none
}

@IBDesignable
open class TipButton: UIView {
    
    ////Properties
    let tipsyYellow:UIColor = UIColor(red: (252.0/255.0), green: (205/255.0), blue: (19/255.0), alpha: (1.0))
    
    @IBInspectable open var shapeColor:UIColor = UIColor(red: (252.0/255.0), green: (205/255.0), blue: (19/255.0), alpha: (1.0)){ //Tipsy yellow
        didSet{
            self.backgroundShape.color = self.shapeColor
        }
    }
    
    open var buttonDescription:ButtonDescription{
        return .none
    }
    
    open var state:State = .deselected{
        didSet{
            switch self.state {
            case .selected:
                self.backgroundShape.drawWithStrokeOnly = true
            case .deselected:
                self.backgroundShape.drawWithStrokeOnly = false
            }
        }
    }
    
    open weak var delegate:TipButtonDelegate?
    
    open var backgroundShape:ShapeView = ShapeView(shape: .circle , color: UIColor(red: (252.0/255.0), green: (205/255.0), blue: (19/255.0), alpha: (1.0)))
    
    
    open var contentView:UIView?{
        didSet{self.setNeedsLayout()}
    }
    
    
    //Initalization
    
    
    convenience public init(backgroundColor:UIColor) {
        
        //init
        self.init(frame:CGRect.zero)
        self.shapeColor = backgroundColor
        self.backgroundShape.color = self.shapeColor
        self.setup()
    }
    //DESIGNATED Initalizer - Also required for Interface Builder
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    
    func setup(){
        //self.translatesAutoresizingMaskIntoConstraints = false

        //add gesture recognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TipButton.tapped))
        
        self.addGestureRecognizer(tapRecognizer)
        
    }
    
    @objc fileprivate func tapped(_ sender:UITapGestureRecognizer){
        
        if sender.state == .ended{
            
            self.delegate?.button(self, willChangeState: self.state)
            
            if self.state == .selected {self.state = .deselected}
            else {self.state = .selected}
            
        }
        
        self.delegate?.button(self, didChangeState: self.state)
        
        NSLog("tapped")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(self.backgroundShape)
        if self.contentView != nil{
            self.backgroundShape.addSubview(contentView!)
            self.contentView?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //add constraints
        self.backgroundShape.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.backgroundShape.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.backgroundShape.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.backgroundShape.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.contentView?.centerXAnchor.constraint(equalTo: self.backgroundShape.centerXAnchor).isActive = true
        self.contentView?.centerYAnchor.constraint(equalTo: self.backgroundShape.centerYAnchor).isActive = true
    }
}
