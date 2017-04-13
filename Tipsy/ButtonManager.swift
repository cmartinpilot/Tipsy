//
//  ButtonManager.swift
//  Tipsy
//
//  Created by Christopher Martin on 4/30/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

import UIKit

public struct ButtonStatus{
    var serviceButtonNumberSelected:Int = 0
    var serviceButtonImages:[UIImage] = []
    var serviceButtonMiniImages:[UIImage] = []
    var amountButtonOn:Bool = false
    var amountText:String?
    var amountButtonColor:UIColor?
    var tailButtonOn:Bool = false
    var tailText:String?
    var tailButtonColor:UIColor?
    var locationButtonOn:Bool = false
    var locationText:String?
    var locationButtonColor:UIColor?
    var legButtonOn:Bool = false
    var legText:String?
    var legButtonColor:UIColor?
}

public protocol ButtonManagerDelegate: class{
    func buttonStatusDidChange(_ status:ButtonStatus)
}


open class ButtonManager:TipButtonDelegate{
    
    static let sharedButtonManager = ButtonManager()
    open weak var delegate:ButtonManagerDelegate?
    var selectedServiceButtons:[ServiceTipButton] = []
    var selectedAmountButton:TextTipButton?
    var selectedTailButton:RectTextTipButton?
    var selectedLocationButton:RectTextTipButton?
    var selectedLegButton:RectTextTipButton?
    
    var selectedButtons:[TipButton] = []
    var customServiceButtons:[TipButton] = []

    
    open func button(_ button:TipButton, willChangeState oldState:State){
        NSLog("buttonWillChangeFrom \(oldState)")
    }
    open func button(_ button:TipButton, didChangeState newState:State){
        NSLog("buttonDidChangeTo \(newState)")
        
        switch newState {
        case .selected:
            
            switch button.buttonDescription{
            case .service:
                //Limit number of service buttons that can be selectd to 4
                //If more are attempted to be selected, don't allow selection
                //and do not add to selected buttons array
                
                if selectedServiceButtons.count < 4{
                    self.selectedServiceButtons.append((button as? ServiceTipButton)!)
                }else{
                    button.state = .deselected
                }
            case .amount:
                self.selectedAmountButton?.state = .deselected
                self.selectedAmountButton = button as? TextTipButton
            case .tail:
                self.selectedTailButton?.state = .deselected
                self.selectedTailButton = button as? RectTextTipButton
            case .location:
                self.selectedLocationButton?.state = .deselected
                self.selectedLocationButton = button as? RectTextTipButton
            case .leg:
                self.selectedLegButton?.state = .deselected
                self.selectedLegButton = button as? RectTextTipButton
            case .none:
                print("None")
            }
            
            let status = self.updateButtonStatus()
            
            //self.selectedButtons.append(button)
            self.delegate?.buttonStatusDidChange(status)
        
        case .deselected:
            
            switch button.buttonDescription{
            case .service:
                for svcButton in self.selectedServiceButtons{
                    if let index = self.selectedServiceButtons.index(of: svcButton){
                        if svcButton == button as? ServiceTipButton{
                            self.selectedServiceButtons.remove(at: index)
                        }
                    }
                }
            case .amount:
                
                self.selectedAmountButton = nil
            case .tail:
                
                self.selectedTailButton = nil
            case .location:
                
                self.selectedLocationButton = nil
            case .leg:
                
                self.selectedLegButton = nil
            case .none:
                print("None")
            }
            
            let status = self.updateButtonStatus()
            
            self.delegate?.buttonStatusDidChange(status)
            
//            for tipButton in (self.selectedButtons){
//                if let index = self.selectedButtons.indexOf(tipButton){
//                    if tipButton == button{
//                        self.selectedButtons.removeAtIndex(index)
//                    }
//                }
//            }
        }
        
        //NSLog("selectedButtons is empty = \(self.selectedButtons.isEmpty)")
        
    }
    
    open func updateButtonStatus() -> ButtonStatus{
        var status = ButtonStatus()
        
        //Service button updated
        status.serviceButtonNumberSelected = self.selectedServiceButtons.count
        for button in self.selectedServiceButtons{
            if let image = button.image{
                status.serviceButtonImages.append(image)
            }
            if let miniImage = button.miniImage{
                status.serviceButtonMiniImages.append(miniImage)
            }
        }
        //Amount button updated
        status.amountButtonOn = self.selectedAmountButton != nil
        status.amountText = self.selectedAmountButton?.text
        status.amountButtonColor = self.selectedAmountButton?.color
    
        //Tail number button updated
        status.tailButtonOn = self.selectedTailButton != nil
        status.tailText = self.selectedTailButton?.text
        status.tailButtonColor = self.selectedTailButton?.color
        
        //Location button updated
        status.locationButtonOn = self.selectedLocationButton != nil
        status.locationText = self.selectedLocationButton?.text
        status.locationButtonColor = self.selectedLocationButton?.color
        
        //Leg button updated
        status.legButtonOn = self.selectedLegButton != nil
        status.legText = self.selectedLegButton?.text
        status.legButtonColor = self.selectedLegButton?.color
        
        return status
    }
    

    //Figure out which button group button is in
    //If in service group allow 4 then unload first button
    //If in any other group allow 1 then unload first button
    //Tell Scoreboard 
    
}



