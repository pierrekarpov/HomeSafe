//
//  BACViewController.swift
//  HomeSafe
//
//  Created by Pierre Karpov on 10/3/15.
//  Copyright © 2015 PierreKarpov. All rights reserved.
//

import UIKit

class BACViewController: UIViewController
{
    @IBOutlet weak var bacLabel: UILabel!
    @IBOutlet weak var drinkCountLabel: UILabel!
    
    var currBAC = 0.0
    var bacCalculator = BACCalculator(weight: 160, sex: true, state: "CA")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = NSUserDefaults.standardUserDefaults()
        
        let userWeight = defaults.stringForKey("userWeight")
        let userSex = defaults.boolForKey("userSex")
        
        if userWeight != nil {
            bacCalculator = BACCalculator(weight: Double(userWeight!)!, sex: userSex, state: "CA")
        }
        
        
    }
    
    @IBAction func AddDrink(sender: UIButton) {
        switch (sender.tag) {
        default: bacCalculator.addDrink(0.6)
        }
        drinkCountLabel.text = "\(drinkCountLabel.text!)\(sender.currentTitle!)"
    }
    
    @IBAction func reset(sender: UIBarButtonItem)
    {
        self.bacCalculator = BACCalculator(weight: 160, sex: true, state: "CA")
        bacLabel.text = "BAC: .00000"
        bacLabel.textColor = UIColor.blackColor()
        self.currBAC = 0.0
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let userWeight = defaults.stringForKey("userWeight")
        let userSex = defaults.boolForKey("userSex")
        
        if userWeight != nil {
            bacCalculator = BACCalculator(weight: Double(userWeight!)!, sex: userSex, state: "CA")
        }
        
        syncBAC()
    }
    
    
    @IBAction func drink() {
        bacCalculator.drink(NSDate())
        getBAC()
        drinkCountLabel.text = ""
        syncBAC()
    }
    
    func syncBAC() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("\(self.currBAC)", forKey: "userCurrentBAC")
    }
    
    func getBAC() {
        
        var bac = bacCalculator.getBAC(NSDate())
        self.currBAC = bac
        if bac < 0.0 {
            bac = 0.0
        }
        bacLabel.text = "BAC: \(bac.string(5))"
        
        if bac >= 0.02 {
            bacLabel.textColor = UIColor.redColor()
        } else {
            bacLabel.textColor = UIColor.blackColor()
        }
        
        //_ = BACCalculatorTester()
    }
}

extension Double {
    func string(fractionDigits:Int) -> String {
        let formatter = NSNumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.stringFromNumber(self) ?? "\(self)"
    }
}

