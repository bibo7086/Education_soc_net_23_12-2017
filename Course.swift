//
//  Courses.swift
//  social_project
//
//  Created by Saeed Ali on 12/13/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import Foundation

import Foundation


public class Courses {
    public var id : Int?
    public var code : String?
    public var name : String?
    public var description : String?
    public var department_id : Int?
    public var semester : String?
    public var year : Int?
    public var readonly : Int?
    public var others : Int?
    public var department : String?
    public var page_id : Int?
    public var instructor : Instructor?
    public var group_id : Int?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let courses_list = Courses.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Courses Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Courses]
    {
        var models:[Courses] = []
        for item in array
        {
            models.append(Courses(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let courses = Courses(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Courses Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        id = Int((dictionary["id"] as? String)!)
        code = dictionary["code"] as? String
        name = dictionary["name"] as? String
        description = dictionary["description"] as? String
        department_id = Int((dictionary["department_id"] as? String)!)
        semester = dictionary["semester"] as? String
        year = Int((dictionary["year"] as? String)!)
        readonly = Int((dictionary["readonly"] as? String)!)
        others = Int((dictionary["others"] as? String)!)
        department = dictionary["department"] as? String
        page_id = Int((dictionary["page_id"] as? String)!)
        if (dictionary["instructor"] != nil) { instructor = Instructor(dictionary: dictionary["instructor"] as! NSDictionary) }
        group_id = Int((dictionary["group_id"] as? String)!)
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.code, forKey: "code")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.description, forKey: "description")
        dictionary.setValue(self.department_id, forKey: "department_id")
        dictionary.setValue(self.semester, forKey: "semester")
        dictionary.setValue(self.year, forKey: "year")
        dictionary.setValue(self.readonly, forKey: "readonly")
        dictionary.setValue(self.others, forKey: "others")
        dictionary.setValue(self.department, forKey: "department")
        dictionary.setValue(self.page_id, forKey: "page_id")
        dictionary.setValue(self.instructor?.dictionaryRepresentation(), forKey: "instructor")
        dictionary.setValue(self.group_id, forKey: "group_id")
        
        return dictionary
    }
    
}
