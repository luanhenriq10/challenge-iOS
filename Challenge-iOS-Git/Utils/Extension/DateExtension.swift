//
//  FormatterUtil.swift
//  Challenge-iOS-Git
//
//  Created by Luan Henrique Damasceno Costa on 03/01/17.
//  Copyright © 2017 Luan Henrique Damasceno Costa. All rights reserved.
//

import UIKit

public extension NSDate {
    public class func dateFromISOString(date: String) -> NSDate {
        let formattedDate = date + "+00:00"

        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"
        let utcDate = dateFormatter.dateFromString(formattedDate)
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        
        let localDateString = dateFormatter.stringFromDate(utcDate!)
        let localDate = dateFormatter.dateFromString(localDateString)!
        
        return localDate
    }
    
    public class func dateFromDate(date: String) -> String {
        
        let dateFormatterDate = NSDateFormatter()
        dateFormatterDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        dateFormatterDate.timeZone = NSTimeZone(name: "UTC")
        let date = dateFormatterDate.dateFromString(date)
        
        dateFormatterDate.dateFormat = "dd/MM/YYYY HH:mm"
        dateFormatterDate.timeZone = NSTimeZone(name: "UTC")
        let timeStamp = dateFormatterDate.stringFromDate(date!)
        
        return timeStamp
    }
}
