//
//  NSDate+iCode.swift
//  iCode
//  Created by Mohamed Shafraz on 20/10/2014.
/*

Copyright (c) 2014, Shafraz Buhary
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
Neither the name of the Copyright holder  nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

import Foundation

extension NSDate {
    
    /*Creates NSDate from given string in given formate */
    convenience
    init(dateString:String, formate:String) {
        let dateFormetter = NSDateFormatter()
        dateFormetter.dateFormat = formate
        let date = dateFormetter.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:date!)
    }
    
    /*Creates NSDate with given year, month and day*/
    convenience
    init(year:Int, month:Int, day:Int) {
        let dateComponents = NSDateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let date = calendar?.dateFromComponents(dateComponents)
        self.init(timeInterval:0, sinceDate:date!)
    }
    
    /*Current date with hour, minute and second*/
    convenience
    init(hour:Int, minute:Int, second:Int) {
        var date = NSDate()
        date = date.dateWithHour(hour, minute: minute, second: second)
        self.init(timeInterval:0, sinceDate:date)
    }
    
    /*Returns date string in given formate*/
    func dateTimeInFormate(formate:String) ->String {
        let dateFormetter = NSDateFormatter()
        dateFormetter.dateFormat = formate
        return dateFormetter.stringFromDate(self)
    }
    
    func dateTimeInFormate(formate:String, timeZone:NSTimeZone) ->String {
        let dateFormetter = NSDateFormatter()
        dateFormetter.dateFormat = formate
        dateFormetter.timeZone = timeZone
        return dateFormetter.stringFromDate(self)
    }
    
    func dateTimeInFormate(formate:String, timeZoneName:String) ->String? {
        
        if let timeZone = NSTimeZone(name: timeZoneName) {
            return self.dateTimeInFormate(formate, timeZone: timeZone)
        }
        return nil
    }
    
    class func currentDateTimeInFormate(formate:String) ->String {
        let currentDateTime = NSDate()
        return currentDateTime.dateTimeInFormate(formate)
    }
    
    
    func utcDateTimeInFormate(formate:String) ->String? {
        return self.dateTimeInFormate(formate, timeZoneName: "UTC")
    }
    
    class func currentUtcDateTimeInFormate(formate:String) ->String? {
        let currentDateTime = NSDate()
        return currentDateTime.utcDateTimeInFormate(formate)
    }
    
    func dateByAddingSeconds(seconds:Int) ->NSDate {
        return self.dateByAddingTimeInterval(NSTimeInterval(seconds))
    }
    
    func dateByAddingMinutes(minutes:Int) ->NSDate {
        return self.dateByAddingTimeInterval(NSTimeInterval(60 * minutes))
    }
    
    func dateByAddingHours(hours:Int) ->NSDate {
        return self.dateByAddingTimeInterval(NSTimeInterval(3600 * hours))
    }
    
    func dateByAddingDays(days:Int) ->NSDate {
        return self.dateByAddingTimeInterval(NSTimeInterval(86400 * days))
    }
    
    func dateByAddingWeeks(weeks:Int) ->NSDate {
        return self.dateByAddingTimeInterval(NSTimeInterval(604800 * weeks))
    }
    
    func timeDiffInMinutesSinceDate(date:NSDate, ignoreSeconds:Bool) ->Int {
        var selfTimeInterval = self.timeIntervalSince1970
        var targatTimeInterval = date.timeIntervalSince1970
        
        /* Removing seconds componants */
        if ignoreSeconds {
            selfTimeInterval = selfTimeInterval / 60;
            targatTimeInterval = targatTimeInterval / 60;
        }
        
        return Int(selfTimeInterval - targatTimeInterval)
    }
    
    func dateWithHour(hour:Int, minute:Int, second:Int) ->NSDate {
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year] , fromDate: self)
        
        components.hour = hour
        components.minute = minute
        components.second = second
        
        return calendar.dateFromComponents(components)!
    }
}