//
//  HomeSafeViewController.swift
//  HomeSafe
//
//  Created by Pierre Karpov on 10/4/15.
//  Copyright © 2015 PierreKarpov. All rights reserved.
//

import UIKit

class HomeSafeViewController: UIViewController {

    @IBOutlet weak var bacLabel: UILabel!
    
    @IBAction func callFriend() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var busPhone = "4153409638"
        
        if let number = defaults.stringForKey("userContactNumber") {
            busPhone = number
        }
        
        if let url = NSURL(string: "tel://\(busPhone)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    func updateUI() {
        var bac = 0.028036666
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let currBAC = defaults.stringForKey("userCurrentBAC")
        
        if currBAC != nil {
            bac = Double(currBAC!)!
        }
        
        
        if bac < 0.0 {
            bac = 0.0
        }
        bacLabel.text = "BAC: \(bac.string(5))"
        
        if bac >= 0.02 {
            bacLabel.textColor = UIColor.redColor()
        } else {
            bacLabel.textColor = UIColor.blackColor()
        }
    }
}
