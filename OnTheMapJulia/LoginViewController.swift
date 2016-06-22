//  LoginViewController.swift
//  OnTheMapJulia
//  Created by Julia Miller on 6/4/16.
//  Copyright © 2016 Julia Miller. All rights reserved.


import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet var incorrect: UILabel!
    
    override func viewDidLoad() {
        incorrect.hidden = true
    }
    
    @IBAction func loginEmail(){
        
        UdacityClient.sharedInstance.login(self.usernameTF.text!, pw: self.passwordTF.text!)
        
    }
    
    @IBAction func signUp(){
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.udacity.com/account/auth#!/signin")!)
    }
    
    @IBAction func loginFacebook(){
        //optional
    }
    
    
}