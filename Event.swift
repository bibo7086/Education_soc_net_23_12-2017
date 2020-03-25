//
//  Events.swift
//  social_project
//
//  Created by Saeed Ali on 1/19/18.
//  Copyright © 2018 Saeed Ali. All rights reserved.
//

import Foundation

public class Event {
    public var id : Int?
    public var time : String?
    public var date : String?
    public var place : String?
    public var post_id : Int?
    public var title : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let event_list = Event.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Event Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Event]
    {
        var models:[Event] = []
        for item in array
        {
            models.append(Event(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let event = Event(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Event Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        id = Int((dictionary["id"] as? String)!)
        time = dictionary["time"] as? String
        date = dictionary["date"] as? String
        place = dictionary["place"] as? String
        post_id = Int((dictionary["post_id"] as? String)!)
        title = dictionary["title"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.time, forKey: "time")
        dictionary.setValue(self.date, forKey: "date")
        dictionary.setValue(self.place, forKey: "place")
        dictionary.setValue(self.post_id, forKey: "post_id")
        dictionary.setValue(self.title, forKey: "title")
        
        return dictionary
    }
    
}
