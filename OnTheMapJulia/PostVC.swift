import Foundation
import UIKit
import MapKit

class PostVC: UIViewController, UITextFieldDelegate {
    
    var searchRequest:MKLocalSearchRequest!
    var search:MKLocalSearch!
    var annotation:MKPointAnnotation!
    
    var address = ""
    var lat = ""
    var long = ""
    var url = ""

    @IBOutlet weak var blueView:UIView!
    @IBOutlet weak var userLocation:UITextField!
    @IBOutlet weak var map:MKMapView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var link: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        self.mapShowing(false)
        link.delegate = self
        activityIndicator.hidden = true
    }
    
    @IBAction func findAddress(sender: AnyObject) {
        
        if userLocation.text == "" {
            print("No location entered.")
        }
        else {
            activityIndicator.hidden = false
            activityIndicator.startAnimating()
            
            searchRequest = MKLocalSearchRequest()
            searchRequest.naturalLanguageQuery = userLocation.text
            search = MKLocalSearch(request: searchRequest)
            search.startWithCompletionHandler{ (searchResponse, error) -> Void in
                
                if searchResponse == nil{
                    self.activityIndicator.hidden = true
                    let alert = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                }
                else {
                    self.activityIndicator.stopAnimating()
                    
                    self.annotation = MKPointAnnotation()
                    let location = CLLocationCoordinate2D(
                        latitude: searchResponse!.boundingRegion.center.latitude,
                        longitude: searchResponse!.boundingRegion.center.longitude)
                    self.annotation.coordinate = location
                    self.map.addAnnotation(self.annotation)
                    let span = MKCoordinateSpanMake(0.02, 0.02)
                    let region = MKCoordinateRegion(center: location, span: span)
                    self.map.setRegion(region, animated: true)
                    self.map.reloadInputViews()
                    
                    self.address = self.userLocation.text!
                    self.lat = String(location.latitude)
                    self.long = String(location.longitude)
                    
                    self.mapShowing(true)

                }
            }
        }
    }
    
    @IBAction func submitLocation(sender: AnyObject) {
        UdacityClient.sharedInstance.postMyLocation(address, url: link.text!, lat: lat, long: long) { (error) -> Void in
            if (error != nil) {
                let alert = UIAlertController(title: nil, message: error, preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
//                let delay = 1.0 * Double(NSEC_PER_SEC)
//                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//                dispatch_after(time, dispatch_get_main_queue(), {
//                    alert.dismissViewControllerAnimated(true, completion: nil)
//                })
            }
        }
        //dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func cancel(sender: AnyObject){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func mapShowing(bool: Bool){
        if (bool) {
            userLocation.hidden = true
            findButton.hidden = true
            questionLabel.hidden = true
            map.hidden = false
            link.hidden = false
            submitButton.hidden = false
            
        } else {
            userLocation.hidden = false
            findButton.hidden = false
            questionLabel.hidden = false
            map.hidden = true
            link.hidden = true
            submitButton.hidden = true
            
        }
    }
    

}
