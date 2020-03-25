//
//  Profile.swift
//  social_project
//
//  Created by Saeed Ali on 12/13/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import Foundation
typealias JSON = [String: Any]
typealias HTTPHeaders = [String: String]


public class Profile {
    public var id : Int?
    public var title : String?
    public var first_name : String?
    public var last_name : String?
    public var email : String?
    public var identification : String?
    public var password : String?
    public var type : Int?
    public var page_id : Int?
    public var department_id : Int?
    public var created_at : String?
    public var updated_at : String?
    public var ext : String?
    public var profile_picture : String?
    public var phone_number : String?
    public var date_of_birth : String?
    public var age : String?
    public var notification_token : String?
    public var message : Message?
    public var from_id : Int?


    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let profile_list = Profile.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Profile Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Profile]
    {
        var models:[Profile] = []
        for item in array
        {
            models.append(Profile(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /*
     Constructs the object based on the given dictionary.
     Sample usage:
     let profile = Profile(someDictionaryFromJSON)
     - parameter dictionary:  NSDictionary from JSON.
     - returns: Profile Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        id = Int((dictionary["id"] as? String)!)
        title = dictionary["title"] as? String
        first_name = dictionary["first_name"] as? String
        last_name = dictionary["last_name"] as? String
        email = dictionary["email"] as? String
        identification =  dictionary["identification"] as? String
        password = dictionary["password"] as? String
        type =  Int((dictionary["type"] as? String)!)
        page_id = Int((dictionary["page_id"] as? String)!)
        department_id = Int((dictionary["department_id"] as? String)!)
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
        ext = dictionary["ext"] as? String
        profile_picture = dictionary["profile_picture"] as? String
        phone_number = dictionary["phone_number"] as? String
        date_of_birth = dictionary["date_of_birth"] as? String
        age = dictionary["age"] as? String
        notification_token = dictionary["notification_token"] as? String
        if (dictionary["message"] != nil) { message = Message(dictionary: dictionary["message"] as! NSDictionary) }
      //  from_id = Int((dictionary["from_id"] as? String)!)


    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.title, forKey: "title")
        dictionary.setValue(self.first_name, forKey: "first_name")
        dictionary.setValue(self.last_name, forKey: "last_name")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.identification, forKey: "identification")
        dictionary.setValue(self.password, forKey: "password")
        dictionary.setValue(self.type, forKey: "type")
        dictionary.setValue(self.page_id, forKey: "page_id")
        dictionary.setValue(self.department_id, forKey: "department_id")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.updated_at, forKey: "updated_at")
        dictionary.setValue(self.ext, forKey: "ext")
        dictionary.setValue(self.profile_picture, forKey: "profile_picture")
        dictionary.setValue(self.phone_number, forKey: "phone_number")
        dictionary.setValue(self.date_of_birth, forKey: "date_of_birth")
        dictionary.setValue(self.age, forKey: "age")
     //   dictionary.setValue(self.from_id, forKey: "from_id")
        
        return dictionary
    }
    
    /** 
     Returns teh full name of the current Instance of the profile
     - returns: String. 
    */
    public func fullName() -> String
    {
        return first_name! + " " +  last_name!
    }
    
}


extension Profile {
    
}
