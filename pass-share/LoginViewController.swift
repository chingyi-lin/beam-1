//
//  LoginViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/14.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var credentialID: String?
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var sitenameLabel: UILabel!
    @IBOutlet weak var activitiyView: UIView!
    
    @IBOutlet weak var segmentedControlBtn: UISegmentedControl!
    
    @IBAction func cancel(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
//        self.performSegue(withIdentifier: "cancelLoginDetailToGoBackMainView", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControlBtn()
        self.detailView.alpha = 1
        self.activitiyView.alpha = 0
        sitenameLabel.text = RealmAPI.shared.read(filterBy: credentialID!).sitename
        self.title = sitenameLabel.text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.detailView.alpha = 1
        self.activitiyView.alpha = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "loginDetailShowDetail"){
            let displayVC = segue.destination as! LoginDetailViewController
            displayVC.credentialID = self.credentialID
            displayVC.loginDetailViewControllerDelegate = self
        }
        if segue.identifier == "loginDetailVCToManageShareVC" {
            let navController = segue.destination as! UINavigationController
            let nextVC = navController.viewControllers.first as! ManageShareViewController
            nextVC.credentialID = self.credentialID
        }
    }
    
    @IBAction func showComponent(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.detailView.alpha = 1
                self.activitiyView.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.detailView.alpha = 0
                self.activitiyView.alpha = 1
            })
        }
    }
    func setupSegmentedControlBtn() {
//        // First segment is selected by default
//        segmentedControlBtn.selectedSegmentIndex = 0
        // TODO: config UI style
//        segmentedControlBtn.backgroundColor = .clear
//        segmentedControlBtn.tintColor = .clear
    }
}
extension LoginViewController: LoginDetailViewControllerDelegate {
    func navigateToManageShareVC() {
        self.performSegue(withIdentifier: "loginDetailVCToManageShareVC", sender: self)
    }
}
