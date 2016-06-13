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
    
    //GET THE SESSION ID AND THE ACCOUNT KEY
    @IBAction func loginEmail(){
        
        let user = self.usernameTF.text!
        let pw = self.passwordTF.text!
        var loginJSONData: NSData!
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(user)\", \"password\": \"\(pw)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) {data, response, error in
            if error != nil {
                print("There was an error")
            }
            else {
                loginJSONData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5))
                //print(NSString(data: newData, encoding: NSUTF8StringEncoding))
            }
        }
        task.resume()
        
        //expected data
        // Optional({"account": {"registered": true, "key": "2987668569"}, "session": {"id": "1481973610S0b90d77a3c1df94ff1becba7903c7192", "expiration": "2016-02-16T11:20:10.019830Z"}})
        
        let parsedJSONData = try! (NSJSONSerialization.JSONObjectWithData(loginJSONData, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary)!
        guard let account = parsedJSONData["account"] as? [String: AnyObject] else {print("no account")
            return}
        guard let account_key = account["key"] as? String else {print("couldn't find account key")
            return}
        guard let session = parsedJSONData["session"] as? [String: AnyObject] else {print("couldn't find session array")
            return}
        guard let session_id = session["id"] as? String else print {"couldn't find session ID")
            return}
        }
        
    }

    @IBAction func signUp(){
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.udacity.com/account/auth#!/signin")!)
    }
    
    @IBAction func loginFacebook(){
    //optional
    }
    
 
    }
}