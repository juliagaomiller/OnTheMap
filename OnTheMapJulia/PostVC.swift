import Foundation
import UIKit
import MapKit

class PostVC: UIViewController {
    
    var searchRequest:MKLocalSearchRequest!
    var search:MKLocalSearch!
    var annotation:MKPointAnnotation!

    @IBOutlet weak var blueView:UIView!
    @IBOutlet weak var userLocation:UITextField!
    @IBOutlet weak var map:MKMapView!
    
    override func viewDidLoad() {
        self.mapShowing(false)
    }
    
    @IBAction func findAddress(sender: AnyObject) {
        
        if userLocation.text == "" {
            //no location entered
        }
        else {
            searchRequest = MKLocalSearchRequest()
            searchRequest.naturalLanguageQuery = userLocation.text
            search = MKLocalSearch(request: searchRequest)
            search.startWithCompletionHandler{ (searchResponse, error) -> Void in
                
                if searchResponse == nil{
                    let alert = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                }
                else {
                    print("Latitude: ", searchResponse!.boundingRegion.center.latitude)
                    print("Longitude: ", searchResponse!.boundingRegion.center.longitude)
                    self.annotation = MKPointAnnotation()
                    self.annotation.coordinate = CLLocationCoordinate2D(
                        latitude: searchResponse!.boundingRegion.center.latitude,
                        longitude: searchResponse!.boundingRegion.center.longitude)
                    self.map.addAnnotation(self.annotation)
                    self.map.reloadInputViews()
                    
                    self.mapShowing(true)
                    print("mapHidden:", self.map.hidden)
                }
            }
        }
    }
    
    func mapShowing(bool: Bool){
        if bool == true {
            map.hidden = false
            blueView.hidden = true
            userLocation.hidden = true
        }
        else {
            map.hidden = true
            blueView.hidden = false
            userLocation.hidden = false
        }
    }
    
    @IBAction func cancel(sender: AnyObject){
        
    }
}
