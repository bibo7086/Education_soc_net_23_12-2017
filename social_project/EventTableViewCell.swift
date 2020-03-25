//
//  EventTableViewCell.swift
//  social_project
//
//  Created by Saeed Ali on 1/19/18.
//  Copyright © 2018 Saeed Ali. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    
    @IBOutlet weak var calanderImage: UIImageView!
    @IBOutlet weak var timeImage: UIImageView!
    @IBOutlet weak var locationImage: UIImageView!
    
}
