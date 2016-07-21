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

class MapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    
    let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    
    override func viewDidLoad() {
        self.showPinsOnMap()
        map.delegate = self
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
            annotation.title = name
            
            if let url = value["mediaURL"] as! String?{
                annotation.subtitle = url
            }
            
            annotations.append(annotation)

        }
        map.addAnnotations(annotations)
        map.reloadInputViews()
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        return annotationView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let url = view.annotation!.subtitle!!   //apparently, you need to unwrap the subtitle twice haha.
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
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


