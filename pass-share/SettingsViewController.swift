//
//  SettingsViewController.swift
//  pass-share
//
//  Created by CY on 2019/5/12.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Todo: iCloud sync properties in state
    
    var profilePickerData: [String] = [String]()
    var profileDict: [String: String] = [:]
    var currentProfileIdx: Int = 0
    
    @IBOutlet weak var demoProfilePicker: UIPickerView!
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBAction func syncOptionChanged(_ sender: UISwitch) {
        let currProfile = RealmAPI.shared.readCurrentProfile()
        RealmAPI.shared.updateProfileSyncOption(for: currProfile, with: sender.isOn)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.demoProfilePicker.delegate = self
        self.demoProfilePicker.dataSource = self
        
        profilePickerData = ["None", "Amy", "CY", "PT"]
        profileDict = ["Amy": "emailone",
                       "CY": "emailtwo",
                       "PT": "emailthree"]
        
        registerBtn.isEnabled = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return profilePickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return profilePickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentProfileIdx = row
        if row != 0 {
            registerBtn.isEnabled = true
        } else {
            registerBtn.isEnabled = false
        }
    }
    
    @IBAction func registerDevice(_ sender: Any) {
        let name = profilePickerData[currentProfileIdx]
        let currProfile = RealmAPI.shared.readCurrentProfile()
        RealmAPI.shared.updateProfileNameAndEmail(for: currProfile, with: name, with: profileDict[name]!)
    }
    @IBAction func resetDemo(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure to delete all local data?", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            RealmAPI.shared.deleteAll()
            RealmAPI.shared.write(data: Profile())
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {action in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true)
    }
}
