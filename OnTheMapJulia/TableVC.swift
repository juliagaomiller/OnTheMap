import Foundation
import UIKit

class TableVC: UITableViewController {
    
    let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    var studentLocations = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        studentLocations = appDelegate.studentLocations
        
    }
    
    @IBAction func refresh(sender: AnyObject) {
        UdacityClient.sharedInstance.getStudentLocations{ (success) -> Void in
            if(success){
                self.studentLocations = self.appDelegate.studentLocations
                self.tableView.reloadData()
            }
        }
        
    }
    @IBAction func postPersLoc(sender: AnyObject) {
        performSegueWithIdentifier("PostVCSegueT", sender: self)
    }
    
    @IBAction func logout(sender: AnyObject) {
        UdacityClient.sharedInstance.logout()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let singleStudent = studentLocations[indexPath.row]
        
        let first = singleStudent["firstName"] as! String
        let last = singleStudent["lastName"] as! String
        let url = singleStudent["mediaURL"] as! String
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = "\(first) \(last)"
        cell.detailTextLabel!.text = "\(url)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let singleStudent = studentLocations[indexPath.row]
        let url = singleStudent["mediaURL"] as! String
        //print(url)
        UIApplication.sharedApplication().openURL(NSURL(string:"\(url)")!)

    }
}