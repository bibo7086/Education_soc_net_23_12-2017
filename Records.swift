//
//  Records.swift
//  social_project
//
//  Created by Saeed Ali on 12/17/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import Foundation

public class Records {
    public var access_token : String?
    public var profile : Profile?
    public var courses : Array<Courses>?
    
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let records_list = Records.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Records Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Records]
    {
        var models:[Records] = []
        for item in array
        {
            models.append(Records(dictionary: item as! NSDictionary)!)
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
        
        access_token = dictionary["access_token"] as? String
        if (dictionary["profile"] != nil) { profile = Profile(dictionary: dictionary["profile"] as! NSDictionary) }
        if (dictionary["courses"] != nil) { courses = Courses.modelsFromDictionaryArray(array: dictionary["courses"] as! NSArray) }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.access_token, forKey: "access_token")
        dictionary.setValue(self.profile?.dictionaryRepresentation(), forKey: "profile")
        
        return dictionary
    }
    
}
