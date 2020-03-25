//
//  EventsTableViewController.swift
//  social_project
//
//  Created by Saeed Ali on 1/18/18.
//  Copyright © 2018 Saeed Ali. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {
    
    static let getEventsPath = "/course/getEvents/"
    static let cellIdentifier = "EventTableViewCell"
    
    var EventPosts: [Event_posts] = [] // Will contain all_events
    var courseDetails: Courses! // Contains course_id
    var currentDate = Date() // to find when a post was made 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        fetchEvents()
     
    }

    // Mark: - get all events
    
    func fetchEvents(){
        let page_id = String(describing: courseDetails.page_id!)
        let URLParams = ["page_id": page_id]
        
        let _ = ProfileViewController.sharedWebClient.load(path: EventsTableViewController.getEventsPath, method: .get, params: URLParams){(data, error) in
            
            /* GUARD: was there an error */
            guard (error == nil) else {
                print(error?.errorDescription! as Any)
                return
            }
            
            guard let events = data?["event_posts"] as? NSArray else {
                print("There was an error getting the events")
                return
            }
            
            self.EventPosts = Event_posts.modelsFromDictionaryArray(array: events as NSArray)
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        

            
            
    }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: EventsTableViewController.cellIdentifier, for: indexPath) as! EventTableViewCell
        
        cell.eventNameLabel.text = EventPosts[indexPath.row].event?.title
        cell.eventDateLabel.text = EventPosts[indexPath.row].event?.date
        cell.eventTimeLabel.text = EventPosts[indexPath.row].event?.time
        cell.eventLocationLabel.text = EventPosts[indexPath.row].event?.place
        
        
        return cell
        
    }
    
    
    

}
