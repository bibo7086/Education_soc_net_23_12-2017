//
//  Instructor.swift
//  social_project
//
//  Created by Saeed Ali on 12/13/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import Foundation

public class Instructor {
    public var first_name : String?
    public var last_name : String?
    public var id : Int?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let instructor_list = Instructor.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Instructor Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Instructor]
    {
        var models:[Instructor] = []
        for item in array
        {
            models.append(Instructor(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let instructor = Instructor(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Instructor Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        first_name = dictionary["first_name"] as? String
        last_name = dictionary["last_name"] as? String
        id = Int((dictionary["id"] as? String)!)
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.first_name, forKey: "first_name")
        dictionary.setValue(self.last_name, forKey: "last_name")
        dictionary.setValue(self.id, forKey: "id")
        
        return dictionary
}
    
    public func fullName()-> String {
        return first_name! + " " + last_name!
    }
}
