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
    var accessArr: [Access]?
    var manageShareTableVC: ManageShareTableViewController?
    
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedLogin = RealmAPI.shared.read(filterBy: credentialID!)
        accessArr = Array(selectedLogin.accessArr)
        if selectedLogin.accessArr.count == 0 {
            //set the alpha view = 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "manageShareVCEmbedSegue" {
            manageShareTableVC = (segue.destination as! ManageShareTableViewController)
            manageShareTableVC?.credentialID = self.credentialID
            manageShareTableVC?.manageShareTableViewControllerDelegate = self
            print("Delegating managetableview")
        }
        if segue.identifier == "mangeShareVCToAddRecipientNav" {
            let navController = segue.destination as! UINavigationController
            let nextVC = navController.viewControllers.first as! AddRecipientViewController
            nextVC.credentialID = self.credentialID
        }
    }
    
    @IBAction func back(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        print("back")
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        print("over")
    }
    
}

extension ManageShareViewController: ManageShareTableViewControllerDelegate {
//    func rowDidSelect(identifierInSelectedRow accessID: String) {
//        print("Select the row with id as \(accessID)")
//        self.accessID = accessID
//        self.performSegue(withIdentifier: "beamTableCellToLoginDetail", sender: self)
//    }
}
