//
//  CommentViewController.swift
//  social_project
//
//  Created by Saeed Ali on 12/30/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITableViewDataSource, CommentTableViewDelegate, UITableViewDelegate {
    typealias  CompletionHandler = (_ success: Bool) -> Void

    
    static let sharedWebClient = WebClient.init(baseUrl: "http://46.101.1.128/api")
    static let cellIdentifier = "MyCommentsCell"
    static let getCommentsPath = "/getComments/"
    static let LikeCommentpath = "/likeComment/"
    static let UnlikeComments = "/dislikeComment/"
    static let SubmitComment = "/submitComment/"
    
    
    var CommentTask: URLSessionDataTask!
    var localComments: [Comments] = []
    var Mypost: Posts! //comment view post to get id of post
    var post_id : String!
    var user_id: String!

    
    
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentButton: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentView.bindToKeyboard()
        commentTextField.clearsOnBeginEditing = true

        //commentTableView.rowHeight = UITableViewAutomaticDimension
        commentTableView.estimatedRowHeight = commentTableView.rowHeight
        
        post_id = String(describing: Mypost.id!)
        user_id = String(describing: Mypost.user_id!)
        // Call the function to get the comments
        getComments(postid: post_id)
        
        
    }
    
    
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    
    }
    
    
    
    func likeButtonPressed(_ sender: CommentTableViewCell) {
        guard let Indexpath = commentTableView.indexPath(for: sender) else { return }
        
        // Call the function to get the comments

        let comment_id = String(describing: localComments[Indexpath.row].id!)
        let URLParams = ["comment_id": comment_id]
        
        
        /* check if already liked */
        if sender.liked ==  false {
            let _   = CommentViewController.sharedWebClient.load(path: CommentViewController.LikeCommentpath, method: .post, params: URLParams){(data, error) in
                guard (error == nil) else {
                    print(error?.errorDescription! as Any)
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
                    
                    self.getComments(postid: self.post_id)

                    
                }
            }
        }
            // Unlike a post
        else {
            let _   = CommentViewController.sharedWebClient.load(path: CommentViewController.UnlikeComments, method: .post, params: URLParams){(data, error) in
                
                guard (error == nil) else {
                    print(error?.errorDescription! as Any)
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
                    self.getComments(postid: self.post_id)
                }
            }
        }
    }
    
    //was the comment button pressed?
    @IBAction func commentButtonPressed(_ sender: Any) {
        if commentTextField.text != nil && commentTextField.text != "Make a comment....." {
            commentButton.isEnabled = false
            postComment(textToUpload: commentTextField.text!) { (isComplete) in
                if isComplete {
                    self.commentButton.isEnabled = true
                    self.getComments(postid: self.post_id)
                }
                else {
                    self.commentButton.isEnabled = true
                    print("there was an error making the comment Post")
                    
                }
            }
        }
        
        
    }
    
    func commentCommentButtonPressed(_ sender: CommentTableViewCell){
       
    }

    // was the comment button pressed after text was input
    
    func postComment( textToUpload: String, completionHandler: @escaping CompletionHandler )
    {
        let bodyObject: [String : Any] = [
            "user_id": self.user_id,
            "post_id": self.post_id,
            "comment": textToUpload,
            "parent_id": "0"
        ]
        let _   = CommentViewController.sharedWebClient.load(path: CommentViewController.SubmitComment, method: .post, params: bodyObject){(data, error) in

            // was the comment succesffully posted
            // Was the Post successfully posted?
            guard (error == nil) else {
                print(error?.errorDescription)
                completionHandler(false)
                return
            }
            
            completionHandler(true)

        
    }
        
    }
    func getComments(postid id: String)
    {
        
        
        let URLParams = ["post_id": id]
        CommentTask = CommentViewController.sharedWebClient.load(path: CommentViewController.getCommentsPath, method: .get, params: URLParams){(data, error) in
            
            /* GUARD: was there an error */
            guard (error == nil) else {
                print(error?.errorDescription! as Any)
                return
            }
            
            /*  Get records from parsed Data */
            guard let records = data?["records"] as? NSArray else {
                print("There was an error parsing the comment data")
                return
            }
            
            self.localComments = Comments.modelsFromDictionaryArray(array: records)
    
            DispatchQueue.main.async {
                self.commentTableView.reloadData()
                
                
            }
        }
    }
}

extension CommentViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localComments.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = commentTableView.dequeueReusableCell(withIdentifier: CommentViewController.cellIdentifier, for: indexPath) as! CommentTableViewCell
        cell.delegate = self
        cell.statusMessage.text = localComments[indexPath.row].comment
        cell.nameLabel.text = localComments[indexPath.row].user?.data?.fullName()
        cell.likesandcomments.text = localComments[indexPath.row].likesandReplies()
        
        //check if ithe comment is already liked 
        let liked_list = localComments[indexPath.row].likes!
        for currentlikes in liked_list
        {
            if(currentlikes.user_id == Mypost.user_id){
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
        if (liked_list.count == 0)
        {
            let image = UIImage(named: "icon-like")!
            cell.likeButton.setImage(image, for: .normal)
            cell.liked = false
            
        }

        
        
        cell.selectionStyle = .none
        return cell
        
    }
}

