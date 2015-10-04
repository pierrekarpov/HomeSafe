//
//  LocationPing.swift
//  HomeSafe
//
//  Created by Pierre Karpov on 10/4/15.
//  Copyright © 2015 PierreKarpov. All rights reserved.
//

import Foundation
import MapKit

class LocationPing: NSObject, MKAnnotation {
    let title: String!
    let timeStamp: NSDate!
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, timeStamp: NSDate, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.timeStamp = timeStamp
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String! {
        return "\(self.timeStamp)"
    }
}