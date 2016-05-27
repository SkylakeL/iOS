//
//  ViewController.swift
//  Map Player
//
//  Created by YIN on 5/26/16.
//  Copyright © 2016 Skylake. All rights reserved.
//

import UIKit

import CoreLocation

class
ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet var latiLabel: UILabel!
    
    @IBOutlet var longLabel: UILabel!
    
    @IBOutlet var altiLabel: UILabel!
    
    @IBOutlet var courseLabel: UILabel!
    
    @IBOutlet var speedLabel: UILabel!
    
    @IBOutlet var addressLabel: UILabel!
    
    
    
    

    var manager: CLLocationManager!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        manager = CLLocationManager()
        
        manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestWhenInUseAuthorization()
        
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var userLocation = locations[0]
        
        self.latiLabel.text = String(userLocation.coordinate.latitude)
        
        self.longLabel.text = String(userLocation.coordinate.longitude)
        
        self.courseLabel.text = String(userLocation.course)
        
        self.altiLabel.text = String(userLocation.altitude)
        
        self.speedLabel.text = String(userLocation.speed)
        
    
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if (error != nil) {
                
                print(error)
                
            } else {
                
                if let p = placemarks?[0] {
                    
                    var addressLabelString: String = ""
                    
                    if p.subThoroughfare != nil {
                        
                        addressLabelString = p.subThoroughfare! + " "
                        
                    }
                    
                    if p.thoroughfare != nil {
                        
                        addressLabelString = addressLabelString + p.thoroughfare! + "\n"
                        
                    }
                    
                    if p.locality != nil {
                        
                        addressLabelString = addressLabelString + p.locality! + ", "
                        
                    }
                    
                    if p.administrativeArea != nil {
                        
                        addressLabelString = addressLabelString + p.administrativeArea! + "\n"
                        
                    }
                    
                    if p.country != nil {
                        
                        addressLabelString = addressLabelString + p.country! + " "
                        
                    }
                    
                    if p.postalCode != nil {
                        
                        addressLabelString = addressLabelString + p.postalCode!
                        
                    }
                    
                    self.addressLabel.text = addressLabelString
                    
                }
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

