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
    
    fileprivate var request: AnyObject?
    
    @IBOutlet weak var segmentedControlBtn: UISegmentedControl!
    @IBOutlet weak var segmentedControlBar: UILabel!
    @IBOutlet weak var siteLogo: UIImageView!
    
    @IBAction func cancel(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControlBtn()
        self.detailView.alpha = 1
        self.activitiyView.alpha = 0
        sitenameLabel.text = RealmAPI.shared.read(filterBy: credentialID!).sitename
        self.title = sitenameLabel.text
        fetchSiteLogo(for: RealmAPI.shared.read(filterBy: credentialID!).domain)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.detailView.alpha = 1
        self.activitiyView.alpha = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "loginDetailShowDetail") {
            let displayVC = segue.destination as! LoginDetailViewController
            displayVC.credentialID = self.credentialID
            displayVC.loginDetailViewControllerDelegate = self
        }
        if (segue.identifier == "loginDetailShowActivity") {
            let displayVC = segue.destination as! LoginActivityTableViewController
            displayVC.credentialID = self.credentialID
        }
        if (segue.identifier == "loginDetailVCToManageShareVC") {
//            let navController = segue.destination as! UINavigationController
//            let nextVC = navController.viewControllers.first as! ManageShareViewController
            let displayVC = segue.destination as! ManageShareViewController
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
    
    @IBAction func showComponent(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.detailView.alpha = 1
                self.activitiyView.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.detailView.alpha = 0
                self.activitiyView.alpha = 1
            })
        }
        UIView.animate(withDuration: 0.3) {
            self.segmentedControlBar.frame.origin.x = (sender.frame.width / CGFloat(sender.numberOfSegments)) * CGFloat(sender.selectedSegmentIndex)
        }
    }
    func setupSegmentedControlBtn() {
        segmentedControlBtn.backgroundColor = .clear
        segmentedControlBtn.tintColor = .clear
        
        segmentedControlBtn.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        
        segmentedControlBtn.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor(red:0.06, green:0.11, blue:0.28, alpha:1.0)
            ], for: .selected)
        
        
    }
    
    func fetchSiteLogo(for domain: String){
        let imgSource = "https://logo.clearbit.com/"
        let targetUrl = URL(string: imgSource + domain + "?size=65")!
        let siteLogoRequest = ImageRequest(url: targetUrl)
        self.request = siteLogoRequest
        siteLogoRequest.load(withCompletion: { [weak self] (siteLogo: UIImage?) in
            guard let siteLogo = siteLogo else {
                return
            }
            self?.siteLogo.image = siteLogo
        })
    }
}
extension LoginViewController: LoginDetailViewControllerDelegate {
    func navigateToManageShareVC() {
        self.performSegue(withIdentifier: "loginDetailVCToManageShareVC", sender: self)
    }
}
