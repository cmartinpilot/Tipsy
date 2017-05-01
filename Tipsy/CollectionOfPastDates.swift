//
//  CollectionOfPastDates.swift
//  Tipsy
//
//  Created by Christopher Martin on 4/30/17.
//  Copyright © 2017 Christopher Martin. All rights reserved.
//

import Foundation

struct CollectionOfPastDates{
    
    var referenceDate:Date
    
    let daysBack:Int
    
    init(fromRefDate refDate:Date, daysToGoBack daysBack:Int) {
        self.referenceDate = refDate
        self.daysBack = daysBack
    }
    
    func generateDates() -> [Date]{
        
        var datesArray:[Date] = []
        let cal = Calendar.current
        var components = DateComponents()
        
        components.hour = 0
        
        cal.enumerateDates(startingAfter: self.referenceDate, matching: components, matchingPolicy: .nextTime, repeatedTimePolicy: .first, direction: .backward) {nextDate, unkonwnBool, stop in
            
            if nextDate != nil{datesArray.insert(nextDate!, at: 0)}
            if datesArray.count - 1 == self.daysBack {stop = true}
        }
        
        print("Today is: \(String(describing: datesArray.last))")
        return datesArray
    }
}
