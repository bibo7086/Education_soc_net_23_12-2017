//
//  image.swift
//  social_project
//
//  Created by Saeed Ali on 12/29/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import Foundation

public class Images {
    public var id : Int?
    public var link : String?
    public var type : String?
    public var post_id : Int?
    public var created_at : String?
 //   public var ext : String?
    public var name : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let images_list = Images.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Images Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Images]
    {
        var models:[Images] = []
        for item in array
        {
            models.append(Images(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let images = Images(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Images Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        id = Int((dictionary["id"] as? String)!)
        link = dictionary["link"] as? String
        type = dictionary["type"] as? String
        post_id = Int((dictionary["post_id"] as? String)!)
        created_at = dictionary["created_at"] as? String
      //  ext = dictionary["ext"] as? String
        name = dictionary["name"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.link, forKey: "link")
        dictionary.setValue(self.type, forKey: "type")
        dictionary.setValue(self.post_id, forKey: "post_id")
        dictionary.setValue(self.created_at, forKey: "created_at")
    //    dictionary.setValue(self.ext, forKey: "ext")
        dictionary.setValue(self.name, forKey: "name")
        
        return dictionary
    }
    
}
