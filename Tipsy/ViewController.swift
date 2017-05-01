//
//  ViewController.swift
//  Tipsy
//
//  Created by Christopher Martin on 3/23/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{

    
    var locationManager:CLLocationManager? = nil
    var nearbyAirports:[Airport] = []{
        didSet{
            for button in locationButtons {
                button.endActivityAnimation()
            }
            print(nearbyAirports.count)
            if nearbyAirports.count > 0{
                var iteration = 0
                for button in locationButtons {
                    button.text = nearbyAirports[iteration].icao
                    iteration += 1
                }
                
            }
            
        }
    }

    //Scoreboard outlets

    @IBOutlet weak var serviceScoreboardButton: ScoreboardButton!
    @IBOutlet weak var amountScoreboardButton: ScoreboardButton!
    @IBOutlet weak var tailScoreboardButton: RectScoreboardButton!
    @IBOutlet weak var locationScoreboardButton: RectScoreboardButton!
    @IBOutlet weak var legScoreboardButton: DiamondScoreboardButton!

    
    
    
    //Service Tip Button outlets
    @IBOutlet weak var tollsServiceTipButton: ServiceTipButton!
    @IBOutlet weak var gpuServiceTipButton: ServiceTipButton!
    @IBOutlet weak var mealServiceTipButton: ServiceTipButton!
    @IBOutlet weak var lineServiceTipButton: ServiceTipButton!
    @IBOutlet weak var globeServiceTipButton: ServiceTipButton!
    @IBOutlet weak var fuelTruckServiceTipButton: ServiceTipButton!
    @IBOutlet weak var cateringServiceTipButton: ServiceTipButton!
    @IBOutlet weak var luggageServiceTipButton: ServiceTipButton!
    @IBOutlet weak var shuttleServiceTipButton: ServiceTipButton!
    @IBOutlet weak var houseKeepingServiceTipButton: ServiceTipButton!
    @IBOutlet weak var lavServiceTipButton: ServiceTipButton!
    
    //Amount Tip Button outlets

    @IBOutlet var amountButtons: [AmountTipButton]!
    
    //Tail Tip Button outlets
    
    @IBOutlet var tailButtons: [TailButton]!
   
//    Location Tip Button outlets
    
    @IBOutlet var locationButtons: [LocationButton]!

    
    let buttonManager = ButtonManager.sharedButtonManager
    let scoreboardManager = ScoreboardManager.sharedScoreboardManager
    
    func tripTapped(){
        print("back")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Items
        let tripNavImage = UIImage(named: "TripsNavigation")
        let tripNavImageView = UIImageView(image: tripNavImage!)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.tripTapped))
        tripNavImageView.addGestureRecognizer(tapGesture)
        let barItem = UIBarButtonItem(customView: tripNavImageView)
        
        self.navigationItem.rightBarButtonItem = barItem
        
        let titleImage = UIImage(named: "Title")
        let titleImageView = UIImageView(image: titleImage!)
        
        self.navigationItem.titleView = titleImageView
        //
        
        //Location Services
        
        if self.isLocationServicesEnabledAndAuthorized() {
            for button in locationButtons {
                button.startActivityAnimation()
            }
            self.locationManager!.requestLocation()
        }
        
        
        //Scoreboard and button delegate assignment
        
        self.buttonManager.delegate = scoreboardManager
        
        self.scoreboardManager.amount   = self.amountScoreboardButton
        self.scoreboardManager.service  = self.serviceScoreboardButton
        self.scoreboardManager.tail     = self.tailScoreboardButton
        self.scoreboardManager.location = self.locationScoreboardButton
        self.scoreboardManager.leg      = self.legScoreboardButton
        //
        

        
        //Service Tip Buttons delegate assignment
        self.tollsServiceTipButton.delegate     = buttonManager
        self.gpuServiceTipButton.delegate       = buttonManager
        self.mealServiceTipButton.delegate      = buttonManager
        self.lineServiceTipButton.delegate      = buttonManager
        self.fuelTruckServiceTipButton.delegate = buttonManager
        self.globeServiceTipButton.delegate     = buttonManager
        self.cateringServiceTipButton.delegate  = buttonManager
        self.luggageServiceTipButton.delegate   = buttonManager
        self.shuttleServiceTipButton.delegate   = buttonManager
        self.houseKeepingServiceTipButton.delegate = buttonManager
        self.lavServiceTipButton.delegate       = buttonManager
        //
        
        //Amount Tip Buttons delegate assignment
        for button in self.amountButtons{
            button.delegate = buttonManager
        }
        //
        
        //Tail tip buttons delegate assignment
        for button in self.tailButtons{
            button.delegate = buttonManager
        }

        //Location buttons delegate assignment
        for button in self.locationButtons {
            button.delegate = buttonManager
        }
        
    }
    
    func isLocationServicesEnabledAndAuthorized() -> Bool{
        guard CLLocationManager.locationServicesEnabled() else {return false}
            
            
        let status:CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        self.locationManager = CLLocationManager()
        
        locationManager!.delegate = self
        
        switch status {
        case .notDetermined:
            self.locationManager!.requestWhenInUseAuthorization()
        case .restricted:
            NSLog("Restricted")
            return false
        case .denied:
            NSLog("Denied")
            return false
        case .authorizedAlways:
            NSLog("AuthorizedAlways")
            return true
        case .authorizedWhenInUse:
            NSLog("AuthorizedWhenInUse")
            return true
        }
        return false
    }
        
    
    //CLLocationManagerDelegate functions
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError: Could not find location")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        Airports.findNear(location: locations[0]){ airports in
            self.nearbyAirports = airports
        }
    }
    
    
}

