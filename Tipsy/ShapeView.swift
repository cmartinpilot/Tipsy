//
//  ShapeView.swift
//  Tipsy
//
//  Created by Christopher Martin on 5/7/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

import UIKit
import QuartzCore

protocol drawsItself {
    var drawWithStrokeOnly: Bool {get set}
    var strokeWithDottedLine: Bool {get set}
    var drawWithStrokeAndFill: Bool {get set}
}


public enum ShapeType {
    case circle
    case roundedRect
    case diamond
}

@IBDesignable
open class ShapeView: UIView, drawsItself {
    @IBInspectable open var color:UIColor = UIColor.brown {
        didSet{
            self.setNeedsDisplay()}
    }
    
    open var drawWithStrokeOnly:Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    open var shape:ShapeType = .circle{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    open var strokeWithDottedLine:Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    open var drawWithStrokeAndFill:Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    //////Initalization
    
    //DESIGNATED Initalizer
    convenience public init(shape:ShapeType, color:UIColor){
        self.init(frame: CGRect.zero)
        self.shape = shape
        self.color = color
        self.backgroundColor = UIColor.clear
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        //self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //Custom Drawing
    override open func draw(_ rect: CGRect) {
        
        let insetBounds = self.bounds.insetBy(dx: 2.0, dy: 2.0)
        var aShape:UIBezierPath
        
        switch self.shape {
        case .circle:
            aShape = UIBezierPath(ovalIn: insetBounds)
        case .roundedRect:
            aShape = UIBezierPath(roundedRect: insetBounds, cornerRadius: 10.0)
        case .diamond:
            let diamond = CGRect(x: 0, y: 0, width: 38.0, height: 38.0)
            aShape = UIBezierPath(roundedRect: diamond, cornerRadius: 10.0)
            
            let deg:Double = 45.0
            let rads:CGFloat = CGFloat(deg * Double.pi / 180)
            let rotation = CGAffineTransform(rotationAngle: rads)
            let translate = CGAffineTransform(translationX: 25.0, y: -2.0)
            
            aShape.apply(rotation)
            aShape.apply(translate)
        }
        
        
        if self.color == UIColor.white {
            UIColor.gray.setStroke()
                aShape.stroke()
        }
        
        if self.drawWithStrokeOnly {
            self.color.setStroke()
            aShape.lineWidth = 3.0
            if self.strokeWithDottedLine{
                aShape.setLineDash([1.0, 7.0], count: 2, phase: 0.0)
                aShape.lineCapStyle = .round
            }
            aShape.stroke()
        }else{
            
            if self.drawWithStrokeAndFill{
                self.color.setStroke()
                aShape.stroke()
            }
            
            self.color.setFill()
            aShape.fill()
        }
    }

}
