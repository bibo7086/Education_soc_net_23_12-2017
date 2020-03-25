//
//  MyPostsTableViewCell.swift
//  social_project
//
//  Created by Saeed Ali on 12/29/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import UIKit

// Implement cell protocls
protocol PostTableViewDelegate: class {
    func likeButtonPressed(_ sender: MyPostsTableViewCell)
    func commentButtonPressed(_ sender: MyPostsTableViewCell)
    
    
}

class MyPostsTableViewCell: UITableViewCell {
    
    var liked = false
    public var defaultPostImageViewHeightConstraint: CGFloat!
    
    weak var delegate: PostTableViewDelegate?
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var statusMessage: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesandcomments: UILabel!
    @IBOutlet weak var postHeightConstraint: NSLayoutConstraint! //Height Constraint for the image
    
    override func prepareForReuse() {
        if postHeightConstraint != nil && defaultPostImageViewHeightConstraint != nil {
            postHeightConstraint.constant = defaultPostImageViewHeightConstraint
        }
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        
        delegate?.likeButtonPressed(self)
        
    }
    
    @IBAction func commentButtonPressed(_ sender: Any) {
        
        delegate?.commentButtonPressed(self)
    }
    
    
}
