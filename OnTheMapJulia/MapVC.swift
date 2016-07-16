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
        self.showPinsOnMap()
    }
    
    @IBAction func reload(sender: AnyObject) {
        loadMapPage()
    }
    
    @IBAction func postPersLoc(sender: AnyObject) {
        self.performSegueWithIdentifier("PostVCSegueM", sender: self)
    }
    @IBAction func logout(sender: AnyObject) {
        UdacityClient.sharedInstance.logout()
        self.dismissViewControllerAnimated(true, completion: nil)
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
    //TRYING TO MAKE THE REFRESH WORK NOW THAT I HAVE ADDED IN THE COMPLETION HANDLERS
        map.removeAnnotations(map.annotations)
        UdacityClient.sharedInstance.getStudentLocations({(success) -> Void in
            if (success){
                self.showPinsOnMap()
            }
        })
    }
}


