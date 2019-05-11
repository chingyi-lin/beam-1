//
//  SetDurationViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/21.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class SetDurationViewController: UIViewController {
    var credentialID: String?
    var newAccess: Access?
    
    @IBOutlet weak var durationTableHeight: NSLayoutConstraint!
    @IBOutlet weak var durationTableView: UIView!
    var tableVC: SetDurationOptionTableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Set Duration"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "setDurationOptionEmbedSegue" {
            let embedVC = (segue.destination as! SetDurationOptionTableViewController)
            embedVC.setDurationOptionTableViewControllerDelegate = self
            tableVC = embedVC
        }
        if segue.identifier == "setDurationToSetSeePassword" {
            let nextVC = (segue.destination as! SetSeePasswordViewController)
            nextVC.newAccess = self.newAccess
            nextVC.credentialID = self.credentialID
        }
    }
}

extension SetDurationViewController: SetDurationOptionTableViewControllerDelegate {
    func rowDidSelect(_ duration: Int) {
        newAccess!.duration = duration
        self.durationTableHeight.constant = self.tableVC!.tableView.contentSize.height
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [],
                       animations: {
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
