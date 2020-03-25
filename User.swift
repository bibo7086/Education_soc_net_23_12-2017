//
//  User.swift
//  social_project
//
//  Created by Saeed Ali on 12/28/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import Foundation

import Foundation


public class User {
    public var data : Profile?
    public var id : Int?
    public var type : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let user_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of User Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [User]
    {
        var models:[User] = []
        for item in array
        {
            models.append(User(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let user = User(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: User Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
         //if (dictionary["user"] != nil) {
      
        if (dictionary["data"] != nil) {
            data = Profile(dictionary: dictionary["data"] as! NSDictionary)
        }

        id = Int((dictionary["id"] as? String)!)
        type = dictionary["type"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.data?.dictionaryRepresentation(), forKey: "profile")
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.type, forKey: "type")
        
        return dictionary
    }
    
}
