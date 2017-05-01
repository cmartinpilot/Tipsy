//
//  DateShifter.swift
//  Tipsy
//
//  Created by Christopher Martin on 4/25/17.
//  Copyright © 2017 Christopher Martin. All rights reserved.
//

import Foundation

//This class is intended to return the day (number) of the month before or after a date.  This will
//allow for displaying a scrolling date that can go backward in time, but never into the future.

open class DateShifter{
    
    //Keeps track of date as we shift it.
    open var current:Date = Date()
    
    //Returns a readable version of current - get only
    open var currentAsInt:Int {
        let dayAsInt = Calendar.current.dateComponents([.day], from: self.current)
        return dayAsInt.day!
    }
    
    //Enum to help make function more readable
    public enum Day {case before(Date), after(Date)}
    
    open func shiftCurrentDayTo(_ day: Day){
        
        switch day {
            
        case let .after(value):
            let components = Calendar.current.dateComponents([.hour], from: value)
            let nextDay = Calendar.current.nextDate(after: value, matching: components, matchingPolicy: .nextTime, repeatedTimePolicy: .first, direction: .forward)
            
            if (nextDay != nil) {
                //If the next day would put it into the future, return today.
                if nextDay! > Date(){
                    self.current = Date()
                }
            }
            
            if nextDay != nil{self.current = nextDay!}
            
        case let .before(value):
            let components = Calendar.current.dateComponents([.hour], from: value)
            let previousDay = Calendar.current.nextDate(after: value, matching: components, matchingPolicy: .nextTime, repeatedTimePolicy: .first, direction: .backward)
            
            if previousDay != nil{self.current = previousDay!}
        }
    }
}
