//
//  ViewController.swift
//  JSON
//
//  Created by YIN on 6/4/16.
//  Copyright © 2016 Skylake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = NSURL(string: "https://freegeoip.net/json/")!
        
        var task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
            if error != nil {
                
                print (error)
                
            } else {
                
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try NSJSONSerialization.JSONObjectWithData((urlContent), options: NSJSONReadingOptions.MutableContainers)
                    
                        print(jsonResult["city"])
                    
                    } catch {
                        
                        
                        
                    }
                
                }
            
            }
            
        }
        
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

