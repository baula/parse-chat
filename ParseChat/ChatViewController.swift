//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Baula Xu on 6/21/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit
import Parse

struct Message {
    var user: NSString
    var text: NSString
}

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    var messages: [Message] = []
    override func viewDidLoad() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        super.viewDidLoad()
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(sender: AnyObject) {
        var message = PFObject(className:"Message_fbuJuly2016")
        message["text"] = textField.text
        message["user"] = PFUser.currentUser()
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("message was saved")
            } else {
                print("\(error!.description)")
            }
        }
        
    }
    
    func refresh() {
        var query = PFQuery(className:"Message_fbuJuly2016")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                if let objects = objects {
                    self.populateMessages(objects)
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func populateMessages(webMessages: [PFObject]) {
        messages = []
        for webMessage in webMessages {
            if let text = webMessage["text"] as? String {
                if let user = webMessage["user"] as? PFUser {
                    if let username = user.username {
                        messages.append(Message(user: username, text: text))
                        print("message appended")
                    }
                }
                
            }
        }
        tableView.reloadData()
    }
    
    func onTimer() {
        refresh()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count: \(messages.count)")
        return messages.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! ChatCell
        let row = indexPath.row
        let chatMessage = messages[row]
        cell.messageLabel.text = chatMessage.text as String
        cell.usernameLabel.text = chatMessage.user as String
        

        print("chatmessage")
        return cell;
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
