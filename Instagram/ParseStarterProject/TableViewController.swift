//
//  TableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by YIN on 6/6/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

import Parse

class TableViewController: UITableViewController {
    
    var usernames = [""]
    
    var userids = [""]
    
    var isFollowing = ["": false]
    
    var refresher: UIRefreshControl!
    
    @IBAction func signOut(sender: AnyObject) {
        
        
        PFUser.logOut()
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    // 更新
    
    func refresh() {
        
        var query = PFUser.query()
        
        query?.findObjectsInBackgroundWithBlock({ (objects, error) in
            
            if let users = objects {
                
                self.usernames.removeAll(keepCapacity: true)
                
                self.userids.removeAll(keepCapacity: true)
                
                self.isFollowing.removeAll(keepCapacity: true)
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        if user.objectId! != PFUser.currentUser()?.objectId {
                            
                            self.usernames.append(user.username!)
                            self.userids.append(user.objectId!)
                            
                            var query = PFQuery(className: "followers")
                            
                            query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
                            query.whereKey("following", equalTo: user.objectId!)
                            
                            query.findObjectsInBackgroundWithBlock({ (objects, error) in
                                
                                if let objects = objects {
                                    
                                    if objects.count > 0 {
                                        
                                        self.isFollowing[user.objectId!] = true
                                        
                                    } else {
                                        
                                        self.isFollowing[user.objectId!] = false
                                        
                                    }
                                    
                                }
                                
                                if self.isFollowing.count == self.usernames.count {
                                    
                                    self.tableView.reloadData()
                                    
                                    self.refresher.endRefreshing()
                                    
                                }
                                
                                
                                
                            })
                            
                            
                            
                        }
                        
                    }
                    
                }
                
            }
            
        })
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "updating..")
        
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableView.addSubview(refresher)
        
        refresh()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.text = usernames[indexPath.row]
        
        let followedObjId = userids[indexPath.row]
        
        if isFollowing[followedObjId] == true {
            
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
        }

        return cell
    }
    
    // 点了表格中的一行才会执行
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        let followedObjId = userids[indexPath.row]
        
        if isFollowing[followedObjId] == false {
            
            isFollowing[followedObjId] = true
        
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
            var following = PFObject(className: "followers")
            
            following["following"] = userids[indexPath.row]
        
            following["follower"] = PFUser.currentUser()?.objectId
        
            following.saveInBackground()
            
        } else {
            
            isFollowing[followedObjId] = false
            
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            var query = PFQuery(className: "followers")
            
            query.whereKey("follower", equalTo: (PFUser.currentUser()?.objectId)!)
            
            query.whereKey("following", equalTo: userids[indexPath.row])
            
            query.findObjectsInBackgroundWithBlock({ (objects, error) in
                
                if let objects = objects {
                    
                    if objects.count > 0 {
                            
                        for object in objects {
                                
                            object.deleteInBackground()
                                
                        }
                            
                    }
                    
                }
                
            })
            
        }
        
        
    }

}
