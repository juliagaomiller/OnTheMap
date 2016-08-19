import Foundation
import UIKit

class TableVC: UITableViewController {
    

    var tempArray = StudentModel.sharedInstance.studentArray
    
    var sharedInstance = StudentModel.sharedInstance
    
    
    override func viewDidLoad() {
        tempArray = sharedInstance.studentArray
        
    }
    
    @IBAction func refresh(sender: AnyObject) {
        UdacityClient.sharedInstance.getStudentLocations{ (success) -> Void in
            if(success){
                self.tempArray = self.sharedInstance.studentArray
                //self.studentLocations = self.appDelegate.studentLocations
                self.tableView.reloadData()
            }
        }
        
    }
    @IBAction func postPersLoc(sender: AnyObject) {
        let postVC = storyboard?.instantiateViewControllerWithIdentifier("PostVC") as! PostVC
        navigationController?.presentViewController(postVC, animated: true, completion: nil)
        //performSegueWithIdentifier("PostVCSegueT", sender: self)
    }
    
    @IBAction func logout(sender: AnyObject) {
        UdacityClient.sharedInstance.logout()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let student = tempArray[indexPath.row]
        
        let name = student.name
        let url = student.url
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = name
        cell.detailTextLabel!.text = url
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let student = tempArray[indexPath.row]
        UIApplication.sharedApplication().openURL(NSURL(string: student.url)!)

    }
}