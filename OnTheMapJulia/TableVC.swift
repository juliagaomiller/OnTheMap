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
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let singleStudent = studentLocations[indexPath.row]
        
        let first = singleStudent["firstName"] as! String
        let last = singleStudent["lastName"] as! String
        
        //print("TableVC24: \(first) \(last)")
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = "\(first) \(last)"
        
        return cell
    }
}