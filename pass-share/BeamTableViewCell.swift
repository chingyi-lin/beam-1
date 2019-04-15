//
//  BeamTableViewCell.swift
//  pass-share
//
//  Created by CY on 2019/4/14.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class BeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    var identifier: String = "none"
}
