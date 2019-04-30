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
    
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedLogin = RealmAPI.shared.read(filterBy: credentialID!)
        accessArr = Array(selectedLogin.accessArr)
        if selectedLogin.accessArr.count == 0 {
            //TODO: show the blank state view - set the alpha view = 1
        }
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
        }
    }
    
    @IBAction func back(_ sender: Any) {
        // Animation: right to left
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ManageShareViewController: ManageShareTableViewControllerDelegate {
    func rowDidSelect(identifierInSelectedRow accessID: String) {
        print("Select the row with id as \(accessID)")
        self.accessID = accessID
        self.performSegue(withIdentifier: "manageShareTableCellToShareDetail", sender: self)
    }
}
