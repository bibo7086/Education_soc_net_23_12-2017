//
//  Feed.swift
//  social_project
//
//  Created by Saeed Ali on 12/23/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import Foundation


public class Feed {
    public var id : Int?
    public var name : String?
    public var image : String?
    public var status : String?
    public var profilePic : String?
    public var timeStamp : Int?
    public var url : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let feed_list = Feed.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Feed Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Feed]
    {
        var models:[Feed] = []
        for item in array
        {
            models.append(Feed(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let feed = Feed(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Feed Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        image = dictionary["image"] as? String
        status = dictionary["status"] as? String
        profilePic = dictionary["profilePic"] as? String
        timeStamp = dictionary["timeStamp"] as? Int
        url = dictionary["url"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.image, forKey: "image")
        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.profilePic, forKey: "profilePic")
        dictionary.setValue(self.timeStamp, forKey: "timeStamp")
        dictionary.setValue(self.url, forKey: "url")
        
        return dictionary
    }
    
}
