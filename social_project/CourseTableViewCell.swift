//
//  CourseTableViewCell.swift
//  social_project
//
//  Created by Saeed Ali on 12/21/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

   
    @IBOutlet weak var courseCodeLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var instructorsNameLabel: UILabel!
    @IBOutlet weak var instructorsImage: UIImageView!
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
