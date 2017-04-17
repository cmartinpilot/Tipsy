//
//  Airports.swift
//  AirportSearch
//
//  Created by Christopher Martin on 7/22/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

//This class requires a file that contains JSON data about airports

import UIKit
import CoreLocation

struct Airport{
    var name:String?
    var icao:String?
    var country:String?
    var location:CLLocationCoordinate2D
}

class Airports{

    //static func worldAirportData() - Returns array of Airport structs
    //static func dumpCache()        - deletes worldAirportDataCache
    //static func findNear(location: CLLocation, completionHandler: [Airport] -> Void) 
    //                               - returns array of Airport structs with just airports nearby
    
    
    
    
    fileprivate static var worldAirportDataCache:[Airport] = []
    
    static func worldAirportData() -> [Airport]{
        
            //If the data is already cached, don't re-parse
            guard worldAirportDataCache.count == 0 else{return worldAirportDataCache}
            
            //Create the path
            guard let path = Bundle.main.path(forResource: "airports", ofType: "json") else{
                print("Airport Class: Cannot find path for airports.json file")
                return []
            }
            
            //Read contents of file into Dictionary
            var parsedAirports:NSDictionary = [:]
            
            do{
                //Grab the data from the file
                let data:Data? = try? Data(contentsOf: URL(fileURLWithPath: path))
                
                //Read the JSON from that file
                if let jsonResult:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    
                    parsedAirports = jsonResult["airports"] as! NSDictionary
                    
                }
            }
            catch
                let error as NSError{
                    print("Error while trying to parse file:\(error.description)")
            }

            
            //Extract info into Airport struct and populate worldAirportDatabase array
            
            var airportDatabase:[Airport] = []
            
            for (_, info) in parsedAirports{
                let icao:String? = (info as AnyObject)["icao"] as? String
                let name:String? = (info as AnyObject)["name"] as? String
                let country:String? = (info as AnyObject)["country"] as? String
                let lat:Double? = (info as AnyObject)["lat"] as? Double
                let lon:Double? = (info as AnyObject)["lon"] as? Double
                
                if (lat != nil) || (lon != nil){
                    let coord:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
                    
                    let airport = Airport(name: name, icao: icao, country: country, location: coord)
                    
                    airportDatabase.append(airport)
                }
            }
            worldAirportDataCache = airportDatabase
            print("Cached the World Database")
            return airportDatabase
        }
    
    static func dumpCache(){
        self.worldAirportDataCache.removeAll()
    }
    
    static func findNear(location: CLLocation, completionHandler: @escaping ([Airport]) -> Void) {
        
        
        //Set the circular region to search
        let region:CLCircularRegion = CLCircularRegion(center: location.coordinate, radius: 90000, identifier: "epicenterOfAirportSearch")
        
        var nearbyAirportsWithDistance = [Double:Airport]()
        
        //Do the the time-consuming work on a background thread
        
        let queue = DispatchQueue(label: "com.nearby.FindAirports", attributes: DispatchQueue.Attributes.concurrent)
        
        queue.async{
            //Iterate over database pulling out airports that are inside circular search region
            
            let airportData = Airports.worldAirportData()
            
            if (airportData.count > 0){
                for airport in airportData {
                    
                    
                    if region.contains(airport.location){
                        
                        //All this is, is a(2) + b(2) = c(2)
                        let x1 = airport.location.latitude
                        let y1 = airport.location.longitude
                        
                        let x2 = location.coordinate.latitude
                        let y2 = location.coordinate.longitude
                        
                        let a = (abs(x1-x2) * (abs(x1-x2)))
                        let b = (abs(y1-y2) * (abs(y1-y2)))
                        
                        let distance = sqrt(a + b)
                        
                        nearbyAirportsWithDistance[distance] = airport
                    }
                }
            }
            
            let sortedAirportsByDistance = nearbyAirportsWithDistance.sorted {$0.0 < $1.0}
            print("Sorted Airports")
            
            var sortedAirportArray:[Airport] = []
            for (_, airport) in sortedAirportsByDistance{
                sortedAirportArray.append(airport)
            }
            DispatchQueue.main.async  {
                completionHandler(sortedAirportArray)
            }
        }
    }
}
