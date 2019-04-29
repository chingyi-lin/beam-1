//
//  ActionableActivityTableViewCell.swift
//  pass-share
//
//  Created by CY on 2019/4/28.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

protocol ActionableActivityTableViewCellDelegate {
    func acceptSharing(with shareInvitationID: String)
}

class ActionableActivityTableViewCell: UITableViewCell {
    
    var actionableActivityTableViewCellDelegate: ActionableActivityTableViewCellDelegate!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    var shareInvitationID: String = ""
    
    
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    
    
    @IBAction func accept(_ sender: Any) {
        actionableActivityTableViewCellDelegate.acceptSharing(with: self.shareInvitationID)
    }
}
