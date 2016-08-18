import Foundation
import UIKit

class TableVC: UITableViewController {
    
    let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    var studentModelArray = [StudentModel]()
    
    override func viewDidLoad() {
        studentModelArray = appDelegate.studentModelArray
        
    }
    
    @IBAction func refresh(sender: AnyObject) {
        UdacityClient.sharedInstance.getStudentLocations{ (success) -> Void in
            if(success){
                self.studentModelArray = self.appDelegate.studentModelArray
                //self.studentLocations = self.appDelegate.studentLocations
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
        return studentModelArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let student = studentModelArray[indexPath.row]
        
        let name = student.name
        let url = student.url
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = name
        cell.detailTextLabel!.text = url
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let student = studentModelArray[indexPath.row]
        UIApplication.sharedApplication().openURL(NSURL(string: student.url)!)

    }
}