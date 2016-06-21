//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Baula Xu on 6/21/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func alert(title: String, message: String) {
        let alertController = UIAlertController(title: "Alert:", message: "Please fill out all text fields", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // handle response here.
        }
        alertController.addAction(OKAction)
        presentViewController(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = emailTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                self.alert("Error", message: "Please fill in all text fields")
                
            } else {
                print("User Registered successfully")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }
        
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(emailTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil{
                print ("you're logged in!")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            else {
                self.alert("Error", message: "Please fill in all text fields")
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
