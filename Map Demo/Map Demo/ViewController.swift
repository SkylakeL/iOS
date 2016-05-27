//
//  ViewController.swift
//  Map Demo
//
//  Created by YIN on 5/25/16.
//  Copyright © 2016 Skylake. All rights reserved.
//

import UIKit

import MapKit

import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        var latitude: CLLocationDegrees = 40.7
        
        var longitude: CLLocationDegrees = -73.9
        
        var latDelta: CLLocationDegrees = 0.01
        
        var lonDelta: CLLocationDegrees = 0.01
        
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: false)
        
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        
        annotation.title = "UMass"
        
        annotation.subtitle = "I'm a student here"
        
        map.addAnnotation(annotation)
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        uilpgr.minimumPressDuration = 1
        
        map.addGestureRecognizer(uilpgr)
        
    }
    
    func action(gestureRecognizer: UIGestureRecognizer) {
        
        print("hihihihi")
        
        var touchPoint = gestureRecognizer.locationInView(self.map)
        
        var newCoordinate: CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = newCoordinate
        
        annotation.title = "new place"
        
        annotation.subtitle = "HiHiHi"
        
        map.addAnnotation(annotation)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        var userLocation: CLLocation = locations[0]
        
        var latitude = userLocation.coordinate.latitude
        
        var longitude = userLocation.coordinate.longitude
        
        var latDelta: CLLocationDegrees = 0.05
        
        var lonDelta: CLLocationDegrees = 0.05
        
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

