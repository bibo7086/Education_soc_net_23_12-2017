//
//  Event_Posts.swift
//  social_project
//
//  Created by Saeed Ali on 1/19/18.
//  Copyright © 2018 Saeed Ali. All rights reserved.
//

import Foundation

public class Event_posts {
    public var id : Int?
    public var text : String?
    public var page_id : Int?
    public var user_id : Int?
    public var parent_id : Int?
    public var announcement : Int?
    public var created_at : String?
    public var updated_at : String?
    public var event : Event?
    public var images : Array<Images>?
    public var videos : Array<String>?
    public var files : Array<String>?
    public var comments : Array<Comments>?
    public var all_comments : Int?
    public var likes : Array<Likes>?
    public var user : User?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let event_posts_list = Event_posts.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Event_posts Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Event_posts]
    {
        var models:[Event_posts] = []
        for item in array
        {
            models.append(Event_posts(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let event_posts = Event_posts(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Event_posts Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        id = Int((dictionary["id"] as? String)!)
        text = dictionary["text"] as? String
        page_id = Int((dictionary["page_id"] as? String)!)
        user_id = Int((dictionary["user_id"] as? String)!)
        parent_id = Int((dictionary["parent_id"] as? String)!)
        announcement = dictionary["announcement"] as? Int
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
        all_comments = dictionary["all_comments"] as? Int

        if (dictionary["event"] != nil) { event = Event(dictionary: dictionary["event"] as! NSDictionary) }
        if (dictionary["images"] != nil ) { images = Images.modelsFromDictionaryArray(array: dictionary["images"] as! NSArray)
            if ((images?.count)! < 1)
            {                images = nil
                
            }
        }
        if (dictionary["videos"] != nil) { videos = dictionary["videos"] as! NSArray as? Array<String> }
        
        if (dictionary["files"] != nil) { files = dictionary["files"] as! NSArray as? Array<String> }
        comments = Comments.modelsFromDictionaryArray(array: dictionary["comments"] as! NSArray)
        if(comments == nil || comments?.isEmpty == true){
            comments = []
        }

        likes = Likes.modelsFromDictionaryArray(array: dictionary["likes"] as! NSArray)
        if(likes == nil || likes?.isEmpty == true){
            likes = []
        }

        if (dictionary["user"] != nil) { user = User(dictionary: dictionary["user"] as! NSDictionary) }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.text, forKey: "text")
        dictionary.setValue(self.page_id, forKey: "page_id")
        dictionary.setValue(self.user_id, forKey: "user_id")
        dictionary.setValue(self.parent_id, forKey: "parent_id")
        dictionary.setValue(self.announcement, forKey: "announcement")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.updated_at, forKey: "updated_at")
        dictionary.setValue(self.event?.dictionaryRepresentation(), forKey: "event")
        dictionary.setValue(self.all_comments, forKey: "all_comments")
        dictionary.setValue(self.user?.dictionaryRepresentation(), forKey: "user")
        
        return dictionary
    }
    
}
