//
//  UserViewController.swift
//  social_project
//
//  Created by Saeed Ali on 10/4/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, PostTableViewDelegate, UITableViewDataSource,UITableViewDelegate {
    
    static let sharedWebClient = WebClient.init(baseUrl: "http://46.101.1.128/api")
    static let LikePostPath = "/likePost/"
    static let UnlikePostPath = "/dislikePost/"
    static let cellIdentifier = "MyPostCell"
    
    var studentProfile: Records!
    var MyPostsTask: URLSessionTask!
    var MyPosts: [Posts] = [] //the posts in the profile view controller
    var currentDate = Date() //to find out when a post was made

    
    @IBOutlet weak var myPostsTableView: UITableView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentsDepartment: UILabel!
    @IBOutlet weak var studentFriendCount: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myPostsTableView.delegate = self
        myPostsTableView.dataSource = self
        
        
        let tbvc = tabBarController as! TabBarViewController
        studentProfile = tbvc.studentProfile
        
        self.myPostsTableView.estimatedRowHeight = self.myPostsTableView.rowHeight
        self.myPostsTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        studentName.text = studentProfile.profile?.fullName()
        studentsDepartment.text = "Computer Engineering"
        studentFriendCount.text = ""
        fetchPost()
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileToComments" {
            let destVC = segue.destination as! CommentViewController
            destVC.Mypost = sender as? Posts
        }
    }
    
    
    func fetchPost(){
        let URLParams = ["start": "0", "limit": "30"]
        MyPostsTask = ProfileViewController.sharedWebClient.load(path: "/profileTimeline/", method: .get, params: URLParams){(data, error) in
            
            /* GUARD: was there an error */
            
            guard (error == nil) else {
                print(error?.errorDescription!)
                return
            }
            
            /*  Get records from parsed Data */
            guard let records = data?["records"] as? NSDictionary else {
                print("There was an error parsing the data")
                return
            }
            
            guard let posts = records["posts"] as? NSArray else {
                print("this timeline has not content")
                return
            }
            
            
            
            self.MyPosts = Posts.modelsFromDictionaryArray(array: posts )
            
            DispatchQueue.main.async {
                self.myPostsTableView.reloadData()
            }
            
            
            
            
            
        }
    }
    
    //This function handles when the like button is pressed
    func likeButtonPressed(_ sender: MyPostsTableViewCell) {
        guard let Indexpath = myPostsTableView.indexPath(for: sender) else { return }
        
        
        let post_id = String(describing: MyPosts[Indexpath.row].id!)
        let URLParams = ["post_id": post_id]
        
        let likes_list = MyPosts[Indexpath.row].likes!
        
        /* check if already liked */
        if sender.liked ==  false {
            let _   = ProfileViewController.sharedWebClient.load(path: ProfileViewController.LikePostPath, method: .post, params: URLParams){(data, error) in
                guard (error == nil) else {
                    print(error?.errorDescription!)
                    return
                }
                
                /*  Get records from parsed Data */
                guard let records = data?["count"] as? Int else {
                    print("There was an error parsing the comment data")
                    return
                }
                
                DispatchQueue.main.async {
                    //  if the like was successful change the icon
                    if records == 1 {
                        let image = UIImage(named: "icon-likeSelected")!
                        sender.likeButton.setImage(image, for: .normal)
                        sender.liked = true
                    }
                        // if the like was not successul leave the icon as it was
                    else {
                        let image = UIImage(named: "icon-like")!
                        sender.likeButton.setImage(image, for: .normal)
                        sender.liked = false
                    }
                    
                    self.fetchPost()

                }
            }
        }
        // Unlike a post 
        else {
            let _   = ProfileViewController.sharedWebClient.load(path: ProfileViewController.UnlikePostPath, method: .post, params: URLParams){(data, error) in
                guard (error == nil) else {
                    print(error?.errorDescription!)
                    return
                }
                
                /*  Get records from parsed Data */
                guard let records = data?["count"] as? Int else {
                    print("There was an error parsing the comment data")
                    return
                }
                
                DispatchQueue.main.async {
                    //  if the like was successful change the icon
                    if records == 0 {
                        let image = UIImage(named: "icon-like")!
                        sender.likeButton.setImage(image, for: .normal)
                        sender.liked = false
                    }
                        // if the like was not successul leave the icon as it was
                    else {
                        let image = UIImage(named: "icon-likeSelected")!
                        sender.likeButton.setImage(image, for: .normal)
                        sender.liked = true
                    }
                    
                    self.fetchPost()
                    
                }
            }
            
        }
        
        
    }
    
    func commentButtonPressed(_ sender: MyPostsTableViewCell)
    {
        guard let Indexpath = myPostsTableView.indexPath(for: sender) else { return }
        
        performSegue(withIdentifier: "ProfileToComments", sender: MyPosts[Indexpath.row])
   
    }
}




extension ProfileViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = myPostsTableView.dequeueReusableCell(withIdentifier: ProfileViewController.cellIdentifier, for: indexPath) as! MyPostsTableViewCell
        
        cell.delegate = self
        cell.nameLabel.text = studentProfile.profile?.fullName()
        cell.statusMessage.text = MyPosts[indexPath.row].text
        
        //check if they already like the pictures
        let likes_list = MyPosts[indexPath.row].likes!
        
        for currentlikes in likes_list
        {
            if(currentlikes.user_id == studentProfile.profile?.id){
                let image = UIImage(named: "icon-likeSelected")!
                cell.likeButton.setImage(image, for: .normal)
                cell.liked = true
            }
            else{
                let image = UIImage(named: "icon-like")!
                cell.likeButton.setImage(image, for: .normal)
                cell.liked = false
            }
            
        }
        if (likes_list.count == 0)
        {
            let image = UIImage(named: "icon-like")!
            cell.likeButton.setImage(image, for: .normal)
            cell.liked = false
            
        }
        
        if(MyPosts[indexPath.row].images != nil){
            
            let link =  "http://46.101.1.128/" + (MyPosts[indexPath.row].images?.first?.link)!
            cell.postImageView.getImage(from: link )
            
        }
        else {
            cell.postImageView.image = nil
            if (cell.postImageView.image == nil || cell.postImageView == nil){
                cell.defaultPostImageViewHeightConstraint = cell.postHeightConstraint.constant
                cell.postHeightConstraint.constant = 0;
                cell.layoutIfNeeded()
            }
            
            
        }
        
        let created_date = MyPosts[indexPath.row].updated_at?.toDateTime()
       
//        print("the current date is \(currentDate)")
//        print("the created date \(created_date)")
        cell.timeAgoLabel.text = currentDate.offsetFrom(date: created_date as! Date)
        cell.likesandcomments.text = MyPosts[indexPath.row].likesandComments()
        cell.selectionStyle = .none
        return cell
        
        
    }
    
    
}




