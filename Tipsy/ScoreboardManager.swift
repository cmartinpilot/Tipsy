//
//  ScoreboardManager.swift
//  Tipsy
//
//  Created by Christopher Martin on 5/21/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

import UIKit

open class ScoreboardManager:ButtonManagerDelegate, ScoreboardButtonDelegate, AttributeTextable{

    static let sharedScoreboardManager:ScoreboardManager = ScoreboardManager()
    
    open var service:ScoreboardButton?
    open var amount:ScoreboardButton?
    open var tail:RectScoreboardButton?
    open var location:RectScoreboardButton?
    open var leg:DiamondScoreboardButton?
    
    
    
    open func buttonStatusDidChange(_ status: ButtonStatus) {
        
        //Service
        switch status.serviceButtonNumberSelected{
        case 0:
            self.service?.changeStateTo(.unfilled, ofColor: nil, withView: nil)
        case 1:
            let view = self.viewForServices(status.serviceButtonNumberSelected, images: status.serviceButtonImages, miniImages: status.serviceButtonMiniImages)
            self.service?.changeStateTo(.filled, ofColor: nil, withView: view)
        case 2...4:
            let view = self.viewForServices(status.serviceButtonNumberSelected, images: status.serviceButtonImages, miniImages: status.serviceButtonMiniImages)
            self.service?.changeStateTo(.multiplefilled, ofColor: nil, withView: view)
        default:
            NSLog("More service butons selected than allowed")
            break
        }
        
        //Amount
        switch status.amountButtonOn{
        case true:
            let view = self.labelForButtonTurnedOnWith(status.amountText!, size: nil)
            self.amount?.changeStateTo(.filled, ofColor: status.amountButtonColor, withView: view)
        case false:
            self.amount?.changeStateTo(.unfilled, ofColor: nil, withView: nil)
        }
        
        //Tail
        switch status.tailButtonOn{
        case true:
            var view:UILabel? = nil
            if let text = status.tailText {
                view = self.labelForButtonTurnedOnWith(text, size: 20.0)
            }
            self.tail?.changeStateTo(.filled, ofColor: status.tailButtonColor, withView: view)
        case false:
            self.tail?.changeStateTo(.unfilled, ofColor: nil, withView: nil)
        }
        
        //Location
        switch status.locationButtonOn{
        case true:
            var view:UILabel? = nil
            if let text = status.locationText{
                view = self.labelForButtonTurnedOnWith(text, size: nil)
            }
            self.location?.changeStateTo(.filled, ofColor: status.locationButtonColor, withView: view)
        case false:
            self.location?.changeStateTo(.unfilled, ofColor: nil, withView: nil)
        }
        
        //Leg
        switch status.legButtonOn{
        case true:
            var view:UILabel? = nil
            if let text = status.legText{
                view = self.labelForButtonTurnedOnWith(text, size: nil)
            }
            self.leg?.changeStateTo(.filled, ofColor: status.legButtonColor, withView: view)
        case false:
            self.leg?.changeStateTo(.unfilled, ofColor: nil, withView: nil)
        }
    }
    
    
    
    open func scoreboardButtonWasSelected(_ button:ScoreboardButton){
        print("scoreboardButtonWasSelected")
    }
    
    
    
    //Helper function to create label for buttons when turned on
    func labelForButtonTurnedOnWith(_ text:String, size:CGFloat?) -> UILabel{
        let label = UILabel()
        var styledText = NSAttributedString()
        if size != nil{
            styledText = self.attributedText(text, WithColor: UIColor.white, size: size!)
        }else{
            styledText = self.attributedText(text, WithColor: UIColor.white, size: 18.0)
        }
        
        label.attributedText = styledText
        return label
    }
    
    //Helper function for services
    func viewForServices(_ selected:Int, images:[UIImage], miniImages:[UIImage]) -> UIView?{
        
        var serviceView:UIView? = nil
        
        switch selected{
        case 1:
            //Display full size set view to serviceView
            serviceView = UIImageView(image: images[0])
        case 2...4:
            //We are going to show 2 or more services so build the view with a Stack View
            
            //Main view
            serviceView = UIView()
            serviceView!.backgroundColor = UIColor.black
            serviceView!.translatesAutoresizingMaskIntoConstraints = false
            serviceView!.widthAnchor.constraint(equalToConstant: 55.0).isActive = true
            serviceView!.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
            
            //Main Stack View
            let mainStackView = UIStackView()
            mainStackView.translatesAutoresizingMaskIntoConstraints = false
            serviceView!.addSubview(mainStackView)
            
            mainStackView.centerXAnchor.constraint(equalTo: serviceView!.centerXAnchor).isActive = true
            mainStackView.centerYAnchor.constraint(equalTo: serviceView!.centerYAnchor).isActive = true
            
            mainStackView.axis = .vertical
            mainStackView.alignment = .center
            mainStackView.distribution = .fillEqually
            mainStackView.spacing = -3.0
            
            //Top Stack View - In the Main Stack View
            let topStackView = UIStackView()
            topStackView.translatesAutoresizingMaskIntoConstraints = false
            topStackView.axis = .horizontal
            topStackView.alignment = .center
            topStackView.distribution = .fillEqually
            topStackView.spacing = -3.0
            
            mainStackView.addArrangedSubview(topStackView)
            
            //Bottom Stack View - In the Main Stack View
            let bottomStackView = UIStackView()
            bottomStackView.translatesAutoresizingMaskIntoConstraints = false
            bottomStackView.axis = .horizontal
            bottomStackView.alignment = .center
            bottomStackView.distribution = .fillEqually
            bottomStackView.spacing = -3.0
            
            mainStackView.addArrangedSubview(bottomStackView)
            
            
            //Depending on how many services we are adding, create that number of shapes
            //and add them to the appropriate stack view
            
            for index in 0..<selected {
                let shape = ShapeView(shape: .circle, color: UIColor(red: (252.0/255.0), green: (205/255.0), blue: (19/255.0), alpha: (1.0)))
                shape.translatesAutoresizingMaskIntoConstraints = false
                shape.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
                shape.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
                let imageView = UIImageView(image: miniImages[index])
                imageView.translatesAutoresizingMaskIntoConstraints = false
                shape.addSubview(imageView)
                imageView.centerXAnchor.constraint(equalTo: shape.centerXAnchor).isActive = true
                imageView.centerYAnchor.constraint(equalTo: shape.centerYAnchor).isActive = true
                
                if (index % 2) == 0{
                    topStackView.addArrangedSubview(shape)
                }else{
                    bottomStackView.addArrangedSubview(shape)}
            }
        default: break
        }
        return serviceView
    }
}
