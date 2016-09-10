//
//  PostImageViewController.swift
//  ParseStarterProject-Swift
//
//  Created by YIN on 6/7/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

import Parse

class PostImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // 提示
    
    func displayAlert(title: String, message: String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet var imageToPost: UIImageView!
    
    @IBAction func upload(sender: AnyObject) {
        
        var image = UIImagePickerController()
        
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        imageToPost.image = image
        
        
        
        
    }
    
    
    
    @IBOutlet var message: UITextField!
    
    
    @IBAction func post(sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        
        activityIndicator.center = self.view.center
        
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        
        var post = PFObject(className: "Post")
        
        post["message"] = message.text
        
        post["userId"] = PFUser.currentUser()!.objectId!
        
        let imageData = UIImageJPEGRepresentation(imageToPost.image!, 9.9)
        
        let imageFile = PFFile(name: "image.png", data: imageData!)
        
        post["imageFile"] = imageFile
        
        post.saveInBackgroundWithBlock { (success, error) in
            
            self.activityIndicator.startAnimating()
            
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            if error == nil {
                    
                self.displayAlert("Image Posted", message: "Posted successfully")
                    
                self.imageToPost.image = UIImage(named: "user-image-with-black-background.png")
                    
                self.message.text = ""
                
            } else {
                
                self.displayAlert("Error", message: "Please try later")
                    
            }
            
        }
        
    }
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
