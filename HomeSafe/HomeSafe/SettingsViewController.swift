//
//  SettingsViewController.swift
//  HomeSafe
//
//  Created by Pierre Karpov on 10/4/15.
//  Copyright © 2015 PierreKarpov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var weightTextView: UITextField!
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    @IBOutlet weak var phoneNumberTextView: UITextField!
    
    struct DefaultSettings {
        static let Weight = 160.0
        static let Sex = true
        static let Number = "0000000000"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightTextView.delegate = self
        phoneNumberTextView.delegate = self
        
        sexSegmentedControl.addTarget(self, action: "syncSettings", forControlEvents: .ValueChanged)
        updateUI()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        syncSettings()
        return true;
    }
    
    func updateUI() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let weight = defaults.stringForKey("userWeight") {
            weightTextView.text = weight
        }
        
        let sex = defaults.boolForKey("userSex")
        if sex {
            sexSegmentedControl.selectedSegmentIndex = 0
        } else {
            sexSegmentedControl.selectedSegmentIndex = 1
        }
    
        if let number = defaults.stringForKey("userContactNumber") {
            phoneNumberTextView.text = number
        }
    }
    
    func syncSettings() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let weight = weightTextView.text
        let number = phoneNumberTextView.text
        let sex = sexSegmentedControl.selectedSegmentIndex
        
        if let weightDouble = Double(weight!) {
            defaults.setDouble(weightDouble, forKey: "userWeight")
        } else {
            defaults.setDouble(DefaultSettings.Weight, forKey: "userWeight")
        }
        
        defaults.setObject(number, forKey: "userContactNumber")
        
        if sex == 0 {
            defaults.setBool(true, forKey: "userSex")
        } else {
            defaults.setBool(false, forKey: "userSex")
        }
        
        //print("weight = \(weight!)\nnumber = \(number!)\nsex = \(sex))")
    }
}
