//
//  MessagesViewController.swift
//  social_project
//
//  Created by Saeed Ali on 1/20/18.
//  Copyright © 2018 Saeed Ali. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    static let cellIdentifier = "MessagesTableViewCell"
    static let getSummaryPath = "/chat/getSummary"
    static let getcourseStudentsPath = "/course/getStudents/"
    
    @IBOutlet weak var messagesTableview: UITableView!
    
    var activeChats: [User] = [] // users you are currently actively chatting wit
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchChats()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessagesToChat" {
            let dest = segue.destination as! UINavigationController
            let destVC = dest.topViewController as! ChatViewController
            
            destVC.targetID = sender as! Int
        }
    }
    
    
    func fetchChats(){
        
        //let URLSPARAMS = ["page_id": "35"]
        let _ = ProfileViewController.sharedWebClient.load(path: MessagesViewController.getSummaryPath, method: .get, params: [String:AnyObject]()){(data, error) in
            //   let _ = ProfileViewController.sharedWebClient.load(path: MessagesViewController.getcourseStudentsPath, method: .get, params: URLSPARAMS){(data, error) in
            
            
            /* GUARD: was there an error */
            
            guard (error == nil) else {
                print(error?.errorDescription! as Any)
                return
            }
            
            /*  Get records from parsed Data */
            guard let summary = data?["summary"] as? NSDictionary else {
                print("There was an error parsing the data")
                return
            }
            
            
            // Iterate through the dictionary and store the content in the chat array
            for key in summary.allKeys {
                let user = summary[key] as! NSDictionary
                self.activeChats.append(User(dictionary: user )!)
            }
            self.activeChats.reverse()
            
            DispatchQueue.main.async {
                self.messagesTableview.reloadData()
            }
        }
    }
}



extension MessagesViewController {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MessagesToChat", sender: activeChats[indexPath.row].id)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeChats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = messagesTableview.dequeueReusableCell(withIdentifier: MessagesViewController.cellIdentifier, for: indexPath) as! MessagesTableViewCell
        cell.recepientNameLabel.text = activeChats[indexPath.row].data?.fullName()
        cell.chatPreviewLabel.text = activeChats[indexPath.row].data?.message?.msg
        cell.timeAgoLabel.text = activeChats[indexPath.row].data?.message?.passed_time
        cell.selectionStyle = .none
        return cell
    }
    
    
}
