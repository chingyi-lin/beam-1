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
    
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        // add child view controller view to container
        if (RealmAPI.shared.readAll().count > 0) {
            
            let controller = storyboard!.instantiateViewController(withIdentifier: "loginBlankState") as! LoginBlankStateViewController
            addChild(controller)
            
            controller.loginBlankStateViewControllerDelegate = self
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(controller.view)
            
            NSLayoutConstraint.activate([
                controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                controller.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
                ])
            
            controller.didMove(toParent: self)
        }
        
    }
    
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

extension BeamViewController:LoginBlankStateViewControllerDelegate {
    func addBtnClicked() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddNewLogin")
        present(vc!, animated: true, completion: nil)
    }
}
