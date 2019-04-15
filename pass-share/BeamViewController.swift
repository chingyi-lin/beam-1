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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "beamTableViewEmbedSegue" {
            beamTableViewController = (segue.destination as! BeamTableViewController)
            beamTableViewController?.beamTableViewControllerDelegate = self
            print("Delegating beamtableview")
        }
    }
}

extension BeamViewController: BeamTableViewControllerDelegate {
    func rowDidSelect(identifierInSelectedRow credentialId: String) {
        print("Select the row with id as \(credentialId)")
        self.performSegue(withIdentifier: "beamTableCellToLoginDetail", sender: self)
    }
}
