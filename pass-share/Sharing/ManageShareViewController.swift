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
            displayVC.shareDetailViewControllerDelegate = self
        }
        if segue.identifier == "manageShareVCToUpdateVC" {
            let displayVC = segue.destination as! UpdatePasswordViewController
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

extension ManageShareViewController: ShareDetailViewControllerDelegate {
    func revoke() {
        self.navigationController?.popViewController(animated: true)
        let alert = UIAlertController(title: "Update Password?", message: "You’ve allowed the recipient to view the password, so we recommend updating your password after revoking their access.\n\nAll other sharers will automatically be synced with the new password.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Not Now", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: {action in self.performSegue(withIdentifier: "manageShareVCToUpdateVC", sender: self)}))
        
        self.present(alert, animated: true)
    }
}
