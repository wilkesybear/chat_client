//
//  ChatController.swift
//  chat_client
//
//  Created by Andrew Wilkes on 9/9/15.
//  Copyright (c) 2015 Andrew Wilkes. All rights reserved.
//

import UIKit
import Parse

class ChatController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var user: PFUser?
    
    var messages: [AnyObject]?

    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func sendButtonClicked(sender: AnyObject) {
        println("Button: Sending \(messageTextField.text)")
        
        var message = PFObject(className:"Message")
        message["user"] = PFUser.currentUser()
        message["text"] = messageTextField.text
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                self.messageTextField.text = ""
                println("Sent a msg!")
            } else {
                // There was a problem, check error.description
            }
        }
    }
    
    @IBAction func editingDidEnd(sender: AnyObject) {
        println("Sending \(messageTextField.text)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let msgs = messages {
            return msgs.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as! MessageCell
        
        let message = messages![indexPath.row] as! PFObject
        
        cell.message = message
        
        return cell
        
    }
    
    func onTimer() {
        // Add code to be run periodically
        
        var query = PFQuery(className:"Message")
        query.orderByDescending("createdAt")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock() {
            (messages: [AnyObject]?, error: NSError?) -> Void in
            if error == nil && messages != nil {
                self.messages = messages
                self.tableView.reloadData()
            } else {
                println(error)
            }
        }
        
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
