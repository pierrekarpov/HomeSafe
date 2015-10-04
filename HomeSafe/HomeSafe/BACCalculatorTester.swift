//
//  BACCalculatorTester.swift
//  HomeSafe
//
//  Created by Pierre Karpov on 10/3/15.
//  Copyright © 2015 PierreKarpov. All rights reserved.
//

import Foundation

public class BACCalculatorTester
{
    var drinkHistoryTest = [(Double, NSDate)]()
    var bacCalculator = BACCalculator(weight: 160.0, sex: true, state: "CA")
    let timeInterval = 60 //in minutes
    
    init() {
        generateData()
        simulateNight()
        printBACHistory()
    }
    
    
    func generateData() {
        let userCalendar = NSCalendar.currentCalendar()
        
        let tenhoursAgo = userCalendar.dateByAddingUnit(
            [.Hour],
            value: -10,
            toDate: NSDate(),
            options: [])!
        let ninehoursAgo = userCalendar.dateByAddingUnit(
            [.Hour],
            value: -9,
            toDate: NSDate(),
            options: [])!
        let sixhoursAgo = userCalendar.dateByAddingUnit(
            [.Hour],
            value: -6,
            toDate: NSDate(),
            options: [])!
        let fourhoursAgo = userCalendar.dateByAddingUnit(
            [.Hour],
            value: -4,
            toDate: NSDate(),
            options: [])!
        let twohoursAgo = userCalendar.dateByAddingUnit(
            [.Hour],
            value: -2,
            toDate: NSDate(),
            options: [])!
        
        drinkHistoryTest = [(5 * 0.6, tenhoursAgo),
                            //(7 * 0.6, ninehoursAgo),
                            (4 * 0.6, sixhoursAgo),
                            //(3 * 0.6, fourhoursAgo),
                            (3 * 0.6, twohoursAgo)]
    }
    
    func simulateNight() {
        for i in 0..<drinkHistoryTest.count {
            let (ounce, time) = drinkHistoryTest[i]
            bacCalculator.addDrink(ounce)
            bacCalculator.drink(time)
        }
    }
    
    func printBACHistory() {
        let currTime = NSDate()
        var (_, tmpTime) = drinkHistoryTest[0]
        while (tmpTime.compare(currTime) != NSComparisonResult.OrderedDescending) {
            print("BAC = \(bacCalculator.getBAC(tmpTime)), at time = \(tmpTime)")
            
            let userCalendar = NSCalendar.currentCalendar()
            tmpTime = userCalendar.dateByAddingUnit(
                [.Minute],
                value: self.timeInterval,
                toDate: tmpTime,
                options: [])!

        }
    }
}