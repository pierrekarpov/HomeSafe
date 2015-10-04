//
//  MapViewController.swift
//  HomeSafe
//
//  Created by Pierre Karpov on 10/4/15.
//  Copyright © 2015 PierreKarpov. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    let regionRadius: CLLocationDistance = 1300
    
    @IBOutlet weak var map: MKMapView! {
        didSet {
            map.mapType = .Hybrid
            map.delegate = self
            
            let initialLocation = CLLocation(latitude: 32.8810, longitude: -117.2380)
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate,
                regionRadius * 2.0, regionRadius * 2.0)
            map.setRegion(coordinateRegion, animated: true)
            
            loadLocationPings()
        }
    }
    
    func loadLocationPings() {
        let location1 = LocationPing(title: "HackSD", timeStamp: NSDate(), coordinate: CLLocationCoordinate2D(latitude: 32.889670, longitude: -117.239692))
        let location2 = LocationPing(title: "Best House", timeStamp: NSDate(), coordinate: CLLocationCoordinate2D(latitude: 32.882156, longitude: -117.244659))
        let location3 = LocationPing(title: "Porter's Pub <3", timeStamp: NSDate(), coordinate: CLLocationCoordinate2D(latitude: 32.876471, longitude: -117.239627))
        let location4 = LocationPing(title: "Blacks Beach", timeStamp: NSDate(), coordinate: CLLocationCoordinate2D(latitude: 32.877805, longitude: -117.251085))
        let location5 = LocationPing(title: "Price Center", timeStamp: NSDate(), coordinate: CLLocationCoordinate2D(latitude: 32.879949, longitude: -117.235990))
        let location6 = LocationPing(title: "Sun God", timeStamp: NSDate(), coordinate: CLLocationCoordinate2D(latitude: 32.878588, longitude: -117.239842))
        
        map.addAnnotation(location1)
        map.addAnnotation(location2)
        map.addAnnotation(location3)
        map.addAnnotation(location4)
        map.addAnnotation(location5)
        map.addAnnotation(location6)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? LocationPing {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
            }
            return view
        }
        return nil
    }
}
