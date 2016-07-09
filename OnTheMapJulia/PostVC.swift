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
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var link: UITextField!
    
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
                    print("(PostVC41)Latitude: ", searchResponse!.boundingRegion.center.latitude)
                    print("(PostVC42)Longitude: ", searchResponse!.boundingRegion.center.longitude)
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
                    
                    self.mapShowing(true)

                }
            }
        }
    }
    
    @IBAction func cancel(sender: AnyObject){
        
    }
    
    func mapShowing(bool: Bool){
        if bool == true {
            userLocation.hidden = true
            findButton.hidden = true
            questionLabel.hidden = true
            map.hidden = false
            link.hidden = false
            submitButton.hidden = false
            
        }
        else {
            findButton.hidden = false
            questionLabel.hidden = false
            userLocation.hidden = false
            map.hidden = true
            link.hidden = true
            submitButton.hidden = true
            
        }
    }
    

}
