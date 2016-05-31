//
//  ViewController.swift
//  memory location
//
//  Created by YIN on 5/27/16.
//  Copyright © 2016 Skylake. All rights reserved.
//

import UIKit

import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet var map: MKMapView!
    
    var manager: CLLocationManager!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        manager = CLLocationManager()
        
        manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        if activePlace == -1 {
            
            manager.requestWhenInUseAuthorization()
            
            manager.startUpdatingLocation()
            
        }
        
        else {
            
            let latitude = NSString(string: places[activePlace]["lat"]!).doubleValue
            
            let longitude = NSString(string: places[activePlace]["lon"]!).doubleValue
            
            var latDelta: CLLocationDegrees = 0.01
            
            var lonDelta: CLLocationDegrees = 0.01
            
            var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            
            var region: MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
            
            self.map.setRegion(region, animated: true)
            
            var annotation = MKPointAnnotation()
            
            annotation.coordinate = coordinate
            
            annotation.title = places[activePlace]["name"]
            
            self.map.addAnnotation(annotation)
            
        }
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        uilpgr.minimumPressDuration = 0.5
        
        map.addGestureRecognizer(uilpgr)
        
    }
    
    func action(gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            
            var touchPoint = gestureRecognizer.locationInView(self.map)
            
            var newCoordinate = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            
            var location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                
                var mytitle = ""
                
                if(error != nil) {
                    
                    print(error)
                    
                }
                
                else {
                    
                    if let p = placemarks?[0] {
                        
                        var subThoroughfare: String = ""
                        
                        var thoroughfare: String = ""
                        
                        if p.subThoroughfare != nil {
                            
                            subThoroughfare = p.subThoroughfare!
                            
                        }
                        
                        if p.thoroughfare != nil {
                            
                            thoroughfare = p.thoroughfare!
                            
                        }
                        
                        mytitle = "\(subThoroughfare) \(thoroughfare)"
                    }
                    
                }
                
                if mytitle.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" {
                    
                    mytitle = "Added \(NSDate())"
                    
                }
                
                places.append(["name":mytitle, "lat":"\(newCoordinate.latitude)", "lon":"\(newCoordinate.longitude)"])
            
                var annotation = MKPointAnnotation()
            
                annotation.coordinate = newCoordinate
            
                annotation.title = mytitle
            
                self.map.addAnnotation(annotation)
                
            })
            
        }
        
    }
    

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var userLocation: CLLocation = locations[0]
        
        var latitude = userLocation.coordinate.latitude
        
        var longitude = userLocation.coordinate.longitude
        
        var latDelta: CLLocationDegrees = 0.01
        
        var lonDelta: CLLocationDegrees = 0.01
        
        var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        
        self.map.setRegion(region, animated: true)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

