//
//  ManageShareTableCell.swift
//  pass-share
//
//  Created by CY on 2019/4/17.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class ManageShareTableCell: UITableViewCell {
    
    @IBOutlet weak var receiverInitial: UILabel!
    @IBOutlet weak var receiverName: UILabel!
    @IBOutlet weak var receiverEmail: UILabel!
    @IBOutlet weak var duration: UIButton!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    var accessID = ""
    
    // TODO: implement it
    @IBAction func clickDuration(_ sender: Any) {
        print("TODO: open duration menu for access ID:")
        print(accessID)
    }
}
