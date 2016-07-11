//
//  MapViewController.swift
//  OnTheMapJulia
//
//  Created by Julia Miller on 6/4/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    
    let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    
    override func viewDidLoad() {
        loadMapPage()
    }
    
    @IBAction func reload(sender: AnyObject) {
        loadMapPage()
    }
    
    @IBAction func postPersLoc(sender: AnyObject) {
        print("About to perform PostVCSegueM")
        self.performSegueWithIdentifier("PostVCSegueM", sender: self)
    }
    @IBAction func logout(sender: AnyObject) {
        
    }
    
    
    
    func showPinsOnMap(){
        

        let studentLocations = appDelegate.studentLocations

        var annotations = [MKPointAnnotation]()
        
        for value in studentLocations {
            //print(value)
            let location = CLLocationCoordinate2DMake(value["latitude"] as! Double, value["longitude"] as! Double)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            var name = ""
            
            if let firstName = value["firstName"] as! String?{
                name = "\(firstName) "
            }
            if let lastName = value["lastName"] as! String?{
                name += "\(lastName)"
            }
            //print(name)
            annotation.title = name
            
            if let url = value["mediaUrl"] as! String?{
                annotation.subtitle = url
            }
            
            annotations.append(annotation)
        }
        map.addAnnotations(annotations)
        map.reloadInputViews()
    }
    
    func loadMapPage(){
        map.removeAnnotations(map.annotations)
        UdacityClient.sharedInstance.getStudentLocations()
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(5), target: self, selector: "showPinsOnMap", userInfo: nil, repeats: false)
    }
    
}
