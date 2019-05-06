//
//  BeamExtTableViewCell.swift
//  credential-provider
//
//  Created by CY on 2019/4/15.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class BeamExtTableViewCell: UITableViewCell {

    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var siteImage: UIImageView!
    @IBOutlet weak var sharedWithImage: UIImageView!
    var identifier: String = "none"
    
    var request: AnyObject?
}
