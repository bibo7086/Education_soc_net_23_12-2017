//
//  Likes.swift
//  social_project
//
//  Created by Saeed Ali on 12/31/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import Foundation

public class CommentLikes {
    public var id : Int?
    public var post_id : Int?
    public var user_id : Int?
    public var created_at : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let likes_list = Likes.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Likes Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [CommentLikes]
    {
        var models:[CommentLikes] = []
        for item in array
        {
            models.append(CommentLikes(dictionary: item as! [String: Any])!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let likes = Likes(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Likes Instance.
     */
    required public init?(dictionary: [String:Any]) {
        
        id = Int((dictionary["id"] as? String)!)
        post_id = Int((dictionary["comment_id"] as? String)!)
        user_id = Int((dictionary["user_id"] as? String)!)
        created_at = dictionary["created_at"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.post_id, forKey: "comment_id")
        dictionary.setValue(self.user_id, forKey: "user_id")
        dictionary.setValue(self.created_at, forKey: "created_at")
        
        return dictionary
    }
    
}
