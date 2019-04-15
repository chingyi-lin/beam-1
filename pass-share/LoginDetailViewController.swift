//
//  LoginDetailViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/14.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class LoginDetailViewController: UIViewController {
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var activitiyView: UIView!
    
    @IBOutlet weak var segmentedControlBtn: UISegmentedControl!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControlBtn()
        self.detailView.alpha = 1
        self.activitiyView.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.detailView.alpha = 1
        self.activitiyView.alpha = 0
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
