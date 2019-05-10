//
//  ManageShareViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/17.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit
class ManageShareViewController: UIViewController {
    
    var credentialID: String?
    var accessID: String?
    var accessArr: [Access]?
    var manageShareTableVC: ManageShareTableViewController?
    
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedLogin = RealmAPI.shared.read(filterBy: credentialID!)
        self.title = selectedLogin.sitename
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "manageShareVCEmbedSegue" {
            manageShareTableVC = (segue.destination as! ManageShareTableViewController)
            manageShareTableVC?.credentialID = self.credentialID
            manageShareTableVC?.manageShareTableViewControllerDelegate = self
        }
        if segue.identifier == "mangeShareVCToAddRecipientNav" {
            let navController = segue.destination as! UINavigationController
            let nextVC = navController.viewControllers.first as! AddRecipientViewController
            nextVC.credentialID = self.credentialID
        }
        if segue.identifier == "manageShareTableCellToShareDetail" {
            let displayVC = (segue.destination as! ShareDetailViewController)
            displayVC.accessID = self.accessID
            displayVC.credentialID = self.credentialID
        }
    }    
}

extension ManageShareViewController: ManageShareTableViewControllerDelegate {
    func rowDidSelect(identifierInSelectedRow accessID: String) {
        print("Select the row with id as \(accessID)")
        self.accessID = accessID
        self.performSegue(withIdentifier: "manageShareTableCellToShareDetail", sender: self)
    }
    func shareBtnClicked() {
        self.performSegue(withIdentifier: "mangeShareVCToAddRecipientNav", sender: self)
        //        let vc = storyboard?.instantiateViewController(withIdentifier: "AddNewLogin")
        //        present(vc!, animated: true, completion: nil)
    }
}
