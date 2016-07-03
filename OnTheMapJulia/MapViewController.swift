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

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    
    let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    
    override func viewDidLoad() {
        UdacityClient.sharedInstance.getStudentLocations()
        //print("printing appDelegate.studentLocations in MapViewController")
        //print(appDelegate.studentLocations)
        //would print []
        
        //ADDED THIS DELAY BECAUSE THE SHOWPINSONMAP FUNCTION KEPT ON GETTING CALLED BEFORE THE SERVER RETURNED THE JSON DATA, I KNOW THERE IS A BETTER WAY TO DO THIS, BUT THIS TECHNIQUE WORKS FOR NOW.
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(5), target: self, selector: "showPinsOnMap", userInfo: nil, repeats: false)
        
    }
    
    @IBAction func reloadMapPage(sender: AnyObject) {
    }
    
    @IBAction func postPersLoc(sender: AnyObject) {
    }
    @IBAction func logout(sender: AnyObject) {
    }
    
    
    
    func showPinsOnMap(){
        //print("running showPinsOnMap")
        //map.removeAnnotations(map.annotations)
        //print("about to print appDelegate student locations")
        //print(appDelegate.studentLocations)
        let studentLocations = appDelegate.studentLocations
        print(studentLocations)
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
    
}
