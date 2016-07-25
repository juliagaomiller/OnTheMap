import Foundation
import UIKit

class UdacityClient {
    
    static let sharedInstance = UdacityClient()
    let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    func login(user: String!, pw: String!, completionHandler: (success: Bool, error: NSError?) -> Void){
        
        var loginJSONData: NSData!
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(user)\", \"password\": \"\(pw)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) {data, response, error in
            if error != nil {
                print("There was an error.")
                completionHandler(success: false, error: error)
                return
            }
            else {
                loginJSONData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5))
            }
            
            let parsedJSONData = try! (NSJSONSerialization.JSONObjectWithData(loginJSONData, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary)!
            
            guard let account = parsedJSONData["account"] as? [String: AnyObject] else {
                print("LoginVC39-no account")
                completionHandler(success: false, error: nil)
                return
            }
            guard let account_key = account["key"] as? String else {
                print("couldn't find account key")
                return
            }
            
            self.appDelegate.accountKey = account_key
            
            completionHandler(success: true, error: nil)
        }
        
        task.resume()
        
    }
    
    func getFirstLastName(completionHandler: (success: Bool) -> Void){
        let url = "https://www.udacity.com/api/users/\(appDelegate.accountKey)"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            data, response, error in
            if error != nil { print("Encountered an error.")
                completionHandler(success: false)
                return
            }
            else {
                let userData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5))
                let json = try! (NSJSONSerialization.JSONObjectWithData(userData, options: .AllowFragments))
                guard let user = json["user"],
                let first = user!["first_name"] as? String,
                let last = user!["last_name"] as? String
                    else { print("Couldn't get first, last name from JSON data")
                        return }
                
                self.appDelegate.firstName = first
                self.appDelegate.lastName = last
            }
                completionHandler(success: true)
        }
        task.resume()
    }
    
    func getStudentLocations(completionHandler: (success: Bool) -> Void){
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request)
            {data, response, error in
                if error != nil { print("There was an error with getStudentLocations request")
                completionHandler(success: false)
                }
                else {
                    let JSONdata = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
                    self.appDelegate.studentLocations = (JSONdata["results"] as? [[String:AnyObject]])!
                    completionHandler(success: true)
                    }
            }
        task.resume()
    }
    
    func postMyLocation(map: String, url: String, lat: String, long: String){
        
        print("App Delegate account key: ", self.appDelegate.accountKey)
        
        let url = "{\"uniqueKey\": \"\(self.appDelegate.accountKey)\", \"firstName\": \"\(self.appDelegate.firstName)\", \"lastName\": \"\(self.appDelegate.lastName)\",\"mapString\": \"\(map)\", \"mediaURL\": \"\(url)\",\"latitude\": \(lat), \"longitude\":\(long)}"
        
        print("UdacityClient: postMyLocation() url: ", url)
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        request.HTTPMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = url.dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            data, response, error in
            if error != nil {
                print("UdacityClient129: Error posting user location: ", error)
            }
            else {
                print("UdacityClient131: Post user location has been successful")
            }
        }
        task.resume()

    }
    
    func logout(){
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "DELETE"
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            data, response, error in
            if error != nil {
                print("UdacityClient147: Error logging out")
            }
            else {
                print("UdacityClient150: Logout succeeded")
            }
        }
        task.resume()
    }
}