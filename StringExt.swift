//
//  StringExt.swift
//  social_project
//
//  Created by Saeed Ali on 1/6/18.
//  Copyright © 2018 Saeed Ali. All rights reserved.
//

import Foundation

extension String
{
    func toDateTime() -> NSDate
    {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        //Specify TimeZone
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        //Parse into NSDate
        let dateFromString : NSDate = dateFormatter.date(from: self)! as NSDate
        
        //Return Parsed Date
        return dateFromString
    }
}
