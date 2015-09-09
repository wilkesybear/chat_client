//
//  ViewController.swift
//  chat_client
//
//  Created by Andrew Wilkes on 9/9/15.
//  Copyright (c) 2015 Andrew Wilkes. All rights reserved.
//

import UIKit

import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var user: PFUser?
    
    @IBAction func loginButtonClicked(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(emailTextField.text, password:passwordTextField.text) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                println("You logged in with \(user?.username)")
                
                self.user = user
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                // The login failed. Check error to see why.
            }
        }
    }
    
    @IBAction func signupButtonClicked(sender: AnyObject) {
        var user = PFUser()
        user.username = emailTextField.text
        user.email = emailTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
                println("You signed up with \(user.email)")
                
                self.user = user
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationViewController = segue.destinationViewController as! UINavigationController
        
        var controller = destinationViewController.topViewController as! ChatController
        
        if let the_user = self.user {
            controller.user = the_user
        }
        
        println("Gonna segue")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

