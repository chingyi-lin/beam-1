//
//  BeamTableViewCell.swift
//  pass-share
//
//  Created by CY on 2019/4/14.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class BeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sitenameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var siteImage: UIImageView!
    @IBOutlet weak var shareWithPic: UIImageView!
    @IBOutlet weak var barMark: UILabel!
    
    var identifier: String = "none"
    var request: AnyObject?
}
