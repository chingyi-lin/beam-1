//
//  SetDurationOptionTableViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/21.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

protocol SetDurationOptionTableViewControllerDelegate {
    func rowDidSelect(_ duration: Int)
}

class SetDurationOptionTableViewController: UITableViewController {
    
    var setDurationOptionTableViewControllerDelegate: SetDurationOptionTableViewControllerDelegate!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row at index: \(indexPath.row)")
//        switch indexPath.row {
//            case 0:
//                duration = 0
//            case 1:
//                duration = 1
//            case 2:
//                duration = -1
//            // TODO: custom date needs to be implemented
//            case 3:
//                duration = -1
//            default:
//                duration = 0
//        }
        setDurationOptionTableViewControllerDelegate.rowDidSelect(indexPath.row)
    }
    
}
