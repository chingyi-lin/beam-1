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
    
    private var oneTimeCellExpanded: Bool = false
    private var thirtyDaysCellExpanded: Bool = false
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0 ) {
            thirtyDaysCellExpanded = false
            if oneTimeCellExpanded {
                oneTimeCellExpanded = false
            } else {
                oneTimeCellExpanded = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        if (indexPath.row == 2) {
            oneTimeCellExpanded = false
            if thirtyDaysCellExpanded {
                thirtyDaysCellExpanded = false
            } else {
                thirtyDaysCellExpanded = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        print("select row at index: \(indexPath.row)")
        setDurationOptionTableViewControllerDelegate.rowDidSelect(indexPath.row)
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0 ) {
            if oneTimeCellExpanded {
                return 120
            } else {
                return 50
            }
        }
        if (indexPath.row == 2) {
            if thirtyDaysCellExpanded {
                return 100
            } else {
                return 50
            }
        }
        return 50
    }
}
