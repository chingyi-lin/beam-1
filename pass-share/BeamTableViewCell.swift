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
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var siteImage: UIImageView!
    
    var identifier: String = "none"
    var request: AnyObject?
}
