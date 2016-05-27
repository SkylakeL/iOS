//
//  ViewController.swift
//  TTT
//
//  Created by YIN on 5/16/16.
//  Copyright © 2016 Skylake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var active = true
    
    @IBOutlet var button: UIButton!
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var playAgainButton: UIButton!
    
    @IBAction func PlayAgain(sender: AnyObject) {
        
        gameState = [0,0,0,0,0,0,0,0,0]
        
        activePlayer = 1
        
        active = true
        
        label.hidden = true
        
        self.label.center = CGPointMake(self.label.center.x - 500, self.label.center.y)
        
        playAgainButton.hidden = true
        
        playAgainButton.center = CGPointMake(self.label.center.x - 500, self.label.center.y)
        
        var buttonClear : UIButton
        
        for var i = 0; i < 9; i++ {
            
            buttonClear = view.viewWithTag(i) as! UIButton
            
            buttonClear.setImage(nil, forState: .Normal)
            
        }
  
    }
    
    
    
    var activePlayer = 1
    
    var gameState = [0,0,0,0,0,0,0,0,0]
    
    let win = [[0, 1, 2],[3, 4, 5],[6, 7, 8],[0, 3, 6],[1, 4, 7],[2, 5, 8],[2, 4, 6],[0, 4, 8]]
    

    
    
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        if gameState[sender.tag] == 0 && active == true {
            
            gameState[sender.tag] = activePlayer
            
            if activePlayer == 1 {
            
                sender.setImage(UIImage(named: "red.jpg"), forState: .Normal)
            
                activePlayer = 2
            
            }
        
            else {
            
                sender.setImage(UIImage(named: "black.jpg"), forState: .Normal)
            
                activePlayer = 1
            
            }
            
            for cb in win {
                
                if(gameState[cb[0]] != 0 && gameState[cb[0]] == gameState[cb[1]] && gameState[cb[1]] == gameState[cb[2]]) {
                    
                    active = false
                    
                    if(gameState[cb[0]] == 1) {
                        
                        label.text = ("单身狗赢啦 xD")
                        
                    }
                    
                    if(gameState[cb[0]] == 2) {
                        
                        label.text = ("王尼玛赢啦 xD")
                        
                    }
                    
                    endGame()
                }
            }
            
            if active == true {
            
                active = false
                
                
                for buttonState in gameState {
                
                if buttonState == 0 {
                    
                    active = true
                    
                }
                
            }
            
            if active == false {
                
                label.text = "Oops 平局喔"
                
                endGame()
            }
        }
    }
    }
    
    
    func endGame() {
        
        label.hidden = false
        playAgainButton.hidden = false
        
        UIView.animateWithDuration(0.5, animations: {
            self.label.center = CGPointMake(self.label.center.x + 500, self.label.center.y)
            
            self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 500, self.playAgainButton.center.y)
        })
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.hidden = true
        
        self.label.center = CGPointMake(self.label.center.x - 500, self.label.center.y)
        
        playAgainButton.hidden = true
        
        playAgainButton.center = CGPointMake(self.label.center.x - 500, self.label.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

