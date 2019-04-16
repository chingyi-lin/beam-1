//
//  BeamViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/14.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit
class BeamViewController: UIViewController {
    var beamTableViewController: BeamTableViewController?
    var credentialID: String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "beamTableViewEmbedSegue" {
            beamTableViewController = (segue.destination as! BeamTableViewController)
            beamTableViewController?.beamTableViewControllerDelegate = self
            print("Delegating beamtableview")
        }
        if segue.identifier == "beamTableCellToLoginDetail" {
            let displayVC = segue.destination as! LoginViewController
            displayVC.credentialID = self.credentialID
        }
    }
}

extension BeamViewController: BeamTableViewControllerDelegate {
    func rowDidSelect(identifierInSelectedRow credentialID: String) {
        print("Select the row with id as \(credentialID)")
        self.credentialID = credentialID
        self.performSegue(withIdentifier: "beamTableCellToLoginDetail", sender: self)
    }
}
