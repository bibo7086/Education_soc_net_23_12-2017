//
//  DateExt.swift
//  social_project
//
//  Created by Saeed Ali on 1/6/18.
//  Copyright © 2018 Saeed Ali. All rights reserved.
// I got this from Github, it was submitted by Adam Studenic
//

import Foundation
extension Date {
    
    func offsetFrom(date: Date) -> String {
        
        let YearMonthWeekDayHourSeconds: Set<Calendar.Component> = [.year,.month, .weekOfMonth, .day, .hour, .minute, .second ]
        let difference = NSCalendar.current.dateComponents(YearMonthWeekDayHourSeconds, from: date, to: self);
        
        let seconds = "\(difference.second ?? 0)secs"
        let minutes = "\(difference.minute ?? 0)mins"
        let hours = "\(difference.hour ?? 0)hrs"
        let days = "\(difference.day ?? 0)days"
        let weeks = "\(difference.weekOfMonth ?? 0)Wks"
        let months = "\(difference.month ?? 0)Months"
        let years = "\(difference.year ?? 0)Yrs"
        
        
        if let year = difference.year, year > 0 { return years }
        if let month = difference.month, month > 0 { return months }
        if let week = difference.weekOfMonth, week > 0 { return weeks }
        if let day = difference.day, day          > 0 { return days }
        if let hour = difference.hour, hour       > 0 { return hours }
        if let minute = difference.minute, minute > 0 { return minutes }
        if let second = difference.second, second > 0 { return seconds }
        
        return ""
    }
    
    
    
    
    
}


