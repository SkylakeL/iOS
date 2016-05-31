//
//  ViewController.swift
//  audio
//
//  Created by YIN on 5/29/16.
//  Copyright © 2016 Skylake. All rights reserved.
//

import UIKit

import AVFoundation



class ViewController: UIViewController {
    
    var name = ["青春修炼手册", "演员", "我是一只鱼"]
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet var BigPic: UIImageView!
    
    @IBOutlet var SmallPic: UIImageView!
    
    
    
    @IBOutlet var songName: UILabel!
    
    
    @IBOutlet var vslider: UISlider!
    
    @IBOutlet var sslider: UISlider!
    
    var cc = 0
    
    var instop = true
    
    @IBAction func back(sender: AnyObject) {
        
        if(cc == 0) {
            
            cc = 2
            
        }
        
        else {
            
            cc = cc - 1
            
        }
        
        songName.text = name[cc]
        
        var strcc = String(cc) + "p.png"
        
        BigPic.image = UIImage(named: strcc)
        
        SmallPic.image = UIImage(named: strcc)
        
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(String(cc), ofType: "mp3")!))
        }
            
        catch {
            
        }
        
        if instop != true {
            
            player.play()
            
            instop = false
            
        }
        
    }
    
    @IBAction func next(sender: AnyObject) {
        
        if(cc == 2) {
            
            cc = 0
            
        }
        
        else {
            
            cc = cc + 1
            
        }
        
        songName.text = name[cc]
        
        var strcc = String(cc) + "p.png"
        
        BigPic.image = UIImage(named: strcc)
        
        SmallPic.image = UIImage(named: strcc)
        
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(String(cc), ofType: "mp3")!))
        }
            
        catch {
            
        }
        
        if instop != true {
        
            player.play()
            
            instop = false
            
        }
    }
    

    
    
    @IBAction func play(sender: AnyObject) {
        
        player.play()
        
        instop = false
        
    }

    
    @IBAction func stop(sender: AnyObject) {
        
        player.pause()
        
        instop = true
        
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(String(cc), ofType: "mp3")!))
        }
            
        catch {
            
        }
        
    }
    
    
    @IBAction func pause(sender: AnyObject) {
        
        player.pause()
        
    }
    
    
    @IBAction func vslider(sender: AnyObject) {
        
        player.volume = vslider.value
        
    }
    
    
    @IBAction func sslider(sender: AnyObject) {
        
        player.currentTime = NSTimeInterval(sslider.value)
        
    }
    
    
    func updatesslider() {
        
        sslider.value = Float(player.currentTime)
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        songName.text = name[cc]
        
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(String(cc), ofType: "mp3")!))
            
            sslider.maximumValue = Float(player.duration)
            
        }
        
        catch {
            
        }
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updatesslider"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

