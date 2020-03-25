//
//  Grades.swift
//  social_project
//
//  Created by Saeed Ali on 1/19/18.
//  Copyright © 2018 Saeed Ali. All rights reserved.
//

import Foundation

public class Grade {
    public var id : Int?
    public var student_number : Int?
    public var page_id : Int?
    public var grade_title : String?
    public var grade : String?
    public var grade_reference : String?
    public var created_at : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let grades_list = Grades.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Grades Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Grade]
    {
        var models:[Grade] = []
        for item in array
        {
            models.append(Grade(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let grades = Grades(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Grades Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        id = Int((dictionary["id"] as? String)!)
        student_number = Int((dictionary["student_number"] as? String)!)

        page_id = Int((dictionary["page_id"] as? String)!)

        grade_title = dictionary["grade_title"] as? String
        grade = dictionary["grade"] as? String
        grade_reference = dictionary["grade_reference"] as? String
        created_at = dictionary["created_at"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.student_number, forKey: "student_number")
        dictionary.setValue(self.page_id, forKey: "page_id")
        dictionary.setValue(self.grade_title, forKey: "grade_title")
        dictionary.setValue(self.grade, forKey: "grade")
        dictionary.setValue(self.grade_reference, forKey: "grade_reference")
        dictionary.setValue(self.created_at, forKey: "created_at")
        
        return dictionary
    }
    
}
