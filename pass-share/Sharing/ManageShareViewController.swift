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
    
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedLogin = RealmAPI.shared.read(filterBy: credentialID!)
        accessArr = Array(selectedLogin.accessArr)
        
        // add blank state subview to container
        if selectedLogin.accessArr.count == 0 {
            //TODO: show the blank state view - set the alpha view = 1
            let controller = storyboard!.instantiateViewController(withIdentifier: "shareBlankState") as! ShareBlankStateViewController
            addChild(controller)
            
            controller.shareBlankStateViewControllerDelegate = self
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

extension ManageShareViewController:ShareBlankStateViewControllerDelegate {
    func shareBtnClicked() {
        self.performSegue(withIdentifier: "mangeShareVCToAddRecipientNav", sender: self)
//        let vc = storyboard?.instantiateViewController(withIdentifier: "AddNewLogin")
//        present(vc!, animated: true, completion: nil)
    }
}
