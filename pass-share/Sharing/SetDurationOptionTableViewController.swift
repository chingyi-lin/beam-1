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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle =  UITableViewCell.SelectionStyle.none
        cell.tintColor = UIColor(red:0.00, green:0.72, blue:0.89, alpha:1.0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        
        if (indexPath.row == 0 ) {
            thirtyDaysCellExpanded = false
            if oneTimeCellExpanded {
                oneTimeCellExpanded = false
            } else {
                oneTimeCellExpanded = true
            }
        }
        if (indexPath.row == 2) {
            oneTimeCellExpanded = false
            if thirtyDaysCellExpanded {
                thirtyDaysCellExpanded = false
            } else {
                thirtyDaysCellExpanded = true
            }
        }
        tableView.beginUpdates()
        tableView.endUpdates()
        print("select row at index: \(indexPath.row)")
        setDurationOptionTableViewControllerDelegate.rowDidSelect(indexPath.row)
        
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // Invoked so we can prepare for a change in selection.
        // Remove previous selection, if any.
        if let selectedIndex = self.tableView.indexPathForSelectedRow {
            // Note: Programmatically deslecting does NOT invoke tableView(:didSelectRowAt:), so no risk of infinite loop.
            self.tableView.deselectRow(at: selectedIndex, animated: false)
            // Remove the visual selection indication.
            self.tableView.cellForRow(at: selectedIndex)?.accessoryType = .none
            oneTimeCellExpanded = false
            thirtyDaysCellExpanded = false
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        return indexPath
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
