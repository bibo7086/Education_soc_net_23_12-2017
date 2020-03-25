//
//  Commets.swift
//  social_project
//
//  Created by Saeed Ali on 12/31/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import Foundation

public class Comments {
    public var id : Int?
    public var created_at : String?
    public var updated_at : String?
    public var comment : String?
    public var parent_id : Int?
    public var post_id : Int?
    public var user_id : Int?
    public var user : User?
    public var replies : Array<String>?
    public var likes : Array<CommentLikes>?

    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let comments_list = Comments.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Comments Instances.
     */
    public class func modelsFromDictionaryArray(array: NSArray) -> [Comments]
    {
        var models:[Comments] = []
        for item in array
        {
            models.append(Comments(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let comments = Comments(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Comments Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        id = Int((dictionary["id"] as? String)!)
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
        comment = dictionary["comment"] as? String
        parent_id = dictionary["parent_id"] as? Int
        post_id = Int((dictionary["post_id"] as? String)!)
        user_id = Int((dictionary["user_id"] as? String)!)
        if (dictionary["user"] != nil) { user = User(dictionary: dictionary["user"] as! NSDictionary) }
        //if (dictionary["replies"] != nil) { replies = Replies.modelsFromDictionaryArray(dictionary["replies"] as! NSArray) }
        
        likes = CommentLikes.modelsFromDictionaryArray(array: dictionary["likes"] as! NSArray)
        if(likes == nil || likes?.isEmpty == true){
            likes = []
        }

    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.updated_at, forKey: "updated_at")
        dictionary.setValue(self.comment, forKey: "comment")
        dictionary.setValue(self.parent_id, forKey: "parent_id")
        dictionary.setValue(self.post_id, forKey: "post_id")
        dictionary.setValue(self.user_id, forKey: "user_id")
        dictionary.setValue(self.user?.dictionaryRepresentation(), forKey: "user")
        
        return dictionary
    }
    public func likesandReplies() -> String
    {
        let localLikes: Int
       // let localComments: Int
        
        if (likes == nil){  localLikes = 0; }
        else{ localLikes = (likes?.count)!    }
        
 
        
        return  " \(localLikes) Like   0 Comments"
    }
    
}
