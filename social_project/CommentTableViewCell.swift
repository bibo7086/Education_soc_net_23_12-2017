//
//  CommentTableViewCell.swift
//  social_project
//
//  Created by Saeed Ali on 12/30/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import UIKit

protocol CommentTableViewDelegate: class {
    func likeButtonPressed(_ sender: CommentTableViewCell)
    func commentCommentButtonPressed(_ sender: CommentTableViewCell)
    
    
}
class CommentTableViewCell: UITableViewCell {
    

    var liked = false 
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var statusMessage: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesandcomments: UILabel!
    
    weak var delegate: CommentTableViewDelegate?
    
    
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        
        delegate?.likeButtonPressed(self)
      
    }
    
    @IBAction func commentButtonPressed(_ sender: Any) {
        
        delegate?.commentCommentButtonPressed(self)
    }
    
    
}

    

