//
//  ShareBlankStateViewController.swift
//  pass-share
//
//  Created by CY on 2019/5/6.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

protocol ShareBlankStateViewControllerDelegate {
    func shareBtnClicked()
}

class ShareBlankStateViewController: UIViewController {
    var shareBlankStateViewControllerDelegate: ShareBlankStateViewControllerDelegate!
    
    
    @IBAction func shareBtnClicked(_ sender: Any) {
        self.shareBlankStateViewControllerDelegate.shareBtnClicked()
    }
    
}
