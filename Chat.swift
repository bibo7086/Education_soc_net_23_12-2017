//
//  Chat.swift
//  social_project
//
//  Created by Saeed Ali on 1/20/18.
//  Copyright © 2018 Saeed Ali. All rights reserved.
//

import Foundation

public class Chats {
    public var id : Int?
    public var msg : String?
    public var from_id : Int?
    public var to_id : Int?
    public var new : String?
    public var created_at : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let records_list = Records.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Records Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Chats]
    {
        var models:[Chats] = []
        for item in array
        {
            models.append(Chats(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let records = Records(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Records Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        id = Int((dictionary["id"] as? String)!)
        msg = dictionary["msg"] as? String
        from_id = Int((dictionary["from_id"] as? String)!)
        to_id = Int((dictionary["to_id"] as? String)!)
        new = dictionary["new"] as? String
        created_at = dictionary["created_at"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.msg, forKey: "msg")
        dictionary.setValue(self.from_id, forKey: "from_id")
        dictionary.setValue(self.to_id, forKey: "to_id")
        dictionary.setValue(self.new, forKey: "new")
        dictionary.setValue(self.created_at, forKey: "created_at")
        
        return dictionary
    }
    
}
