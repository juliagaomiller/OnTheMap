import Foundation
import UIKit

class TableVC: UITableViewController {
    
    var collection: [StudentModel] {
        return StudentModel.collection
    }
    
    override func viewDidLoad() {
    }
    
    @IBAction func refresh(sender: AnyObject) {
        UdacityClient.sharedInstance.getStudentLocations{ (success) -> Void in
            if(success){
                self.tableView.reloadData()
            }
        }
        
    }
    @IBAction func postPersLoc(sender: AnyObject) {
        let postVC = storyboard?.instantiateViewControllerWithIdentifier("PostNC")
        navigationController?.presentViewController(postVC!, animated: true, completion: nil)
    }
    
    @IBAction func logout(sender: AnyObject) {
        UdacityClient.sharedInstance.logout()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentModel.collection.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let student = collection[indexPath.row]
        
        let name = student.first + " " + student.last
        let url = student.url
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = name
        cell.detailTextLabel!.text = url
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let student = collection[indexPath.row]
        UIApplication.sharedApplication().openURL(NSURL(string: student.url)!)

    }
}