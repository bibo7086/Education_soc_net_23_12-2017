//
//  Message.swift
//  social_project
//
//  Created by Saeed Ali on 1/20/18.
//  Copyright © 2018 Saeed Ali. All rights reserved.
//

import Foundation

public class Message {
    public var passed_time : String?
    public var created_at : String?
    public var msg : String?
    public var sent : Int?
    public var new : Int?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let message_list = Message.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Message Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Message]
    {
        var models:[Message] = []
        for item in array
        {
            models.append(Message(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let message = Message(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Message Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        passed_time = dictionary["passed_time"] as? String
        created_at = dictionary["created_at"] as? String
        msg = dictionary["msg"] as? String
        sent = dictionary["sent"] as? Int
        new = dictionary["new"] as? Int
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.passed_time, forKey: "passed_time")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.msg, forKey: "msg")
        dictionary.setValue(self.sent, forKey: "sent")
        dictionary.setValue(self.new, forKey: "new")
        
        return dictionary
    }
    
}
