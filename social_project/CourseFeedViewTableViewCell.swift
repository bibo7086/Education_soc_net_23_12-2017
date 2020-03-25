//
//  CourseFeedViewTableViewCell.swift
//  social_project
//
//  Created by Saeed Ali on 1/9/18.
//  Copyright © 2018 Saeed Ali. All rights reserved.
//

import UIKit
// Implement cell protocls
protocol CourseFeedTableViewCellDelegate: class {
    func likeButtonPressed(_ sender: CourseFeedViewTableViewCell)
    func commentButtonPressed(_ sender: CourseFeedViewTableViewCell)
}


class CourseFeedViewTableViewCell: UITableViewCell {

    public var defaultPostImageViewHeightConstraint: CGFloat!
    
    var liked = false
    
    weak var delegate: CourseFeedTableViewCellDelegate?
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var statusMessage: UILabel!
    @IBOutlet weak var likeandcommentsLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        delegate?.likeButtonPressed(self)
    }
    
    
    @IBAction func commentButtonPressed(_ sender: UIButton) {
        delegate?.commentButtonPressed(self)
    }
    
    @IBOutlet weak var postHeightConstraint: NSLayoutConstraint!
    
    override func prepareForReuse() {
        if postHeightConstraint != nil && defaultPostImageViewHeightConstraint != nil {
            postHeightConstraint.constant = defaultPostImageViewHeightConstraint
        }
    }

    
}
