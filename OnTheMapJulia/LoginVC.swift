//  LoginViewController.swift
//  OnTheMapJulia
//  Created by Julia Miller on 6/4/16.
//  Copyright © 2016 Julia Miller. All rights reserved.


import Foundation
import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    
    @IBOutlet var incorrect: UILabel!
    
    let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    override func viewDidLoad() {
        incorrect.hidden = true
        activityInd.hidden = true
        usernameTF.delegate = self
        passwordTF.delegate = self
        usernameTF.placeholder = "Username"
        passwordTF.placeholder = "Password"
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    @IBAction func loginEmail(){
        
        self.activityInd.hidden = false
        self.activityInd.startAnimating()
        UdacityClient.sharedInstance.login(self.usernameTF.text!, pw: self.passwordTF.text!, completionHandler: {(success, error) in
            if (!success) {
                var alert: UIAlertController!
                if error != nil {
                    alert = UIAlertController(title: "Error", message: "Issue with network connectivity", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                } else {
                    alert = UIAlertController(title: "Error", message: "Invalid username or password", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                }
                performUpdatesOnMain({ () -> Void in
                    self.presentViewController(alert, animated: true, completion: nil);
                    self.activityInd.hidden = true
                })
            } else {
                UdacityClient.sharedInstance.getFirstLastName({ (success) -> Void in
                    if(success){
                        performUpdatesOnMain({ () -> Void in
                            UdacityClient.sharedInstance.getStudentLocations({ (success) -> Void in
                                if(success){
                                    performUpdatesOnMain({ () -> Void in
                                        self.activityInd.stopAnimating()
                                        self.activityInd.hidden = true
                                        self.performSegueWithIdentifier("MapViewSegue", sender: nil)
                                    })
                                    
                                }
                            })
                        
                        })
                    }
                })
            }
        })
        
    }
    
    @IBAction func signUp(){
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.udacity.com/account/auth#!/signin")!)
    }
}